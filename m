Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E7A4EB499
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 22:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiC2UWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 16:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiC2UWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:22:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B05412221F;
        Tue, 29 Mar 2022 13:20:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TKJ0Zx016838;
        Tue, 29 Mar 2022 20:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ombhn2JI+0zB0Y6thVPFTkRfZywnj+VrSgPys/uKJGM=;
 b=Lhg48aTQn+bBcsQgBayGvc8MAXuzbu47hHrNhC5bHeOn+8U0tR5pC0ZlciiNaKZDc/Qb
 QvZAdA8xHSsJNMXNWV+nNmQfHTyvyDOlD7xQbso5PvAIKQDVzaK9z7ROQ7XCGnT5fZK7
 NntgDKH/nA0UHejlVudsOLxzMX2JaxYKgoetYZPTtNjTlJCej8cpvWuuGkLokT0T8NGN
 IgbcFYZDAVl8EpOE/QEEVeHYrQvyf+ucq5K2hjxtrVdkGHXS1UDllPMEAb3Wwl/zGa/G
 ZEmIyRx+cwMS/8V08phcH786AwFUtxTNvvgNl3X86qnqrxZW5HFj5t71kdI1RqC5tv0C yA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cqj41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 20:20:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TJtlGU142138;
        Tue, 29 Mar 2022 20:20:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3030.oracle.com with ESMTP id 3f1qxqft1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 20:20:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWE76Oej1xb3YOoYDKpybgZWCYuApQysf58+hJ684r/1G8xi3Poi8zsej1ViA1/3nAm8PCEPpH1pxLs+OKfytvmQM3jhViHuoqx3FOqrVKgz4dGgLr36KCOm/uDLmT87rZVEsExxOubE0nqXCxmom9Cx/ibPG1GJnmTKF1UYPf5X5seqFTaolOwVhiZsYlHc9aToI/wogqm7NC/RvnG2W3S8TK4AFj+hKigqgCstZC2RDn4018pkGhsXQ+yQEjQnQDiz95XGu7K4TWLgxb7r5AHqeFIGo5CmAdlkzQ7hq/QhVO9k+UIXD/2mR3hx6TwD+QigW5C8m9QbeL1Zg81Nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ombhn2JI+0zB0Y6thVPFTkRfZywnj+VrSgPys/uKJGM=;
 b=JAYMdALGZ+DgoD1vdKC1J3cAZga1Ci94XX2N0cPzFjnXDoMgByj6TwWnyDHMaS2n5Mg3CE3kHf/yKkWiI2sbntDYROXETeGRoFAFWvkR4OOWB1n6egEv2JlOyPRS1Ec+CP/Eo4CWjHri2yKZMWjt+JPIVVLcN8triYYqF+x8alssRKCs8bBwJGAoBkZkL4wpdpMZ8JL3ImJypfA+fxSucku4VR/VHgExzLznfSvs/YMHADC6nFTyn58LiCmFQTM6/lURwEJF84T07qzCvHmN7ftgvO/exn2lp/W2CYiMv+RHWbvQ3gJ7soj/q0YPWPSUb5rAbLABTz5IPARRTr1MXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ombhn2JI+0zB0Y6thVPFTkRfZywnj+VrSgPys/uKJGM=;
 b=E0TV15Q9/bPkuqhiP0FpaWG7sxCnJyL/egv5BLqZMHOyU3krW8d3UePWsq+6kuNPCxBVF3eJGYigGI6TMjquH0z6zn74YWhfGSxUn55u6BIjpmwmGyKZMlHvg7h+Hvs8zvLyyBJaAejaJKNY8BYL2fTfZInxaiK9YJE4qkWDOzc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2493.namprd10.prod.outlook.com (2603:10b6:805:41::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 20:20:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 20:20:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Thread-Topic: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and
 spinlock to support courteous server
Thread-Index: AQHYQAGu2vXHyzFxzEOK5co/7sorDqzWiKwAgAAI/wCAAALWgIAAHqSAgAAFbQCAAA7/AIAABI+AgAACqACAAADAgIAABWQA
Date:   Tue, 29 Mar 2022 20:20:45 +0000
Message-ID: <D87C59B4-EA6B-49D8-A587-60911B2BF451@oracle.com>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-3-git-send-email-dai.ngo@oracle.com>
 <20220329154750.GE29634@fieldses.org>
 <612ef738-20f6-55f0-1677-cc035ba2fd0d@oracle.com>
 <20220329163011.GG29634@fieldses.org>
 <5cddab8d-dd92-6863-78fd-a4608a722927@oracle.com>
 <20220329183916.GC32217@fieldses.org>
 <ED3991C3-0E66-439F-986E-7778B2C81CDB@oracle.com>
 <20220329194915.GD32217@fieldses.org>
 <ACF56E81-BAB9-4102-A4C3-AB03DE1BAE76@oracle.com>
 <20220329200127.GE32217@fieldses.org>
In-Reply-To: <20220329200127.GE32217@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d049bf79-3f59-49e7-735b-08da11c19aef
x-ms-traffictypediagnostic: SN6PR10MB2493:EE_
x-microsoft-antispam-prvs: <SN6PR10MB249376539FA51BA1C58C9B46931E9@SN6PR10MB2493.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dEqkX0DbZD73C0PXH5xxmwsblQmCRQgHw3dOCThTsAAy+XShK6r8bSS9r2YxlFQpI9INE3d5+JzW/XG1mRRGa4juUdI34jYRAYEFRuyEH3xqcIJjDpwbgJPqCcsJyUJ61tUj/MVUn+lzxkLKjGiws2ILJJkVM48sWlgnib7w7vWOIEaav72ZQumG/TeQhF0tTbvlpLGen7BOk8oGSFpip56eRsuVTWyTMSS79GLgBbOoGFBXkvH3JitAZlksSYxJx67fcBwxumyIukTylAUhCPc7KdwxsRBqeDVLqrMSm4dwa2hiMLPmTRprbvn5sIDFhctDnoehvnIT4eksNrXwvNPl7MtiRP0QGVzDm6+BMQq/zTFbEXxaz7b6ere223c7QuD4GeFmGMlxnVKFW21f+1d2T0TS0HvZf58XlWyTHKpXLZ516j5rIqagKZYAnq8lsehKKj+KQExT5XgoXeaMOAPKIwpaalMs2FN7JJAjkNhrk+MAlrDtWpOIAFVHEZePkXZ1MJCBEsqxFQ2wozHrf91q1mVfNsY1XwiQDk4ubIFig6YVOFXV0l090rWURNm1z50hBSzf9WntmxqphUfV+HNGVF9oSY8a4JHisb9L1o05v9b9YIpnJyhy8+E0PV6HOaRiFXGnshFK74DMzgjIqQmDehc09lgLvXKyPqBIvefIXAmxDMfZv0KQCjQpaXgRyahfWx+uZjrXO3LDFAewUkNsU6LUgYf6p8U9UP02CMg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(186003)(6916009)(54906003)(38070700005)(86362001)(316002)(6512007)(83380400001)(26005)(2616005)(38100700002)(66446008)(4326008)(8676002)(8936002)(71200400001)(91956017)(64756008)(122000001)(6486002)(508600001)(66556008)(6506007)(66946007)(66476007)(76116006)(53546011)(5660300002)(2906002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c2LuVgBdwMq8gBTdByZONYYTbcpTnqtxg9ApoMvgKTShxHghvQUmCOHUBaEs?=
 =?us-ascii?Q?utKtJ41WFWOjbSBlXDHxK1Z0jCuiXsYj7lytH3S/PczMmFYQqZE8DwroDA5V?=
 =?us-ascii?Q?ySM9G9aOgdgn7DcBJ0hI9hNbqgxNQc726xszggT4fgN0GEeIVNSEIIITs5Qi?=
 =?us-ascii?Q?v0FRm3npg/OaINUlj0QrjWNrEwKAbB/+zha7fcAoFiUMKBMK7spDSw63062T?=
 =?us-ascii?Q?hGGrr0oGsKtzTa+25aitzuevgVAJTnf8g/4+gLeeMHPTQtEGs/vjRps2DV7k?=
 =?us-ascii?Q?kg5Io5APswMRDAbXQscnk0pJFYHZRV0ft6twDkYMNN/cIqnJFMecyfGmnQ1R?=
 =?us-ascii?Q?VXNVW3U2757yk5TpldG6RPFc8C5cZfwJAf227hpwQkdYCfmMH+QMP/izUfMk?=
 =?us-ascii?Q?o0QaJFqujVWEjXd5BVUeCZEHtgp6r1EBWAAKV2EAwsBEn+8yDNhuNrS5wiHC?=
 =?us-ascii?Q?dFHi++KhUd/c9mMdd2Od2HyWFbuqo9CfpQ3AR7aRoFtGvy0QrSvI0OjFTKOh?=
 =?us-ascii?Q?jUhNnFmoVEX3w3St2/3UBn9105R4ELRMl3E8Uzx0ZhAmpcz/zyNVbs+45ajO?=
 =?us-ascii?Q?uanE4AWD9PPzTYwyYWcUUueClKLEybM2enhQabL/hNatZvU9z9Ejlcg3QlpQ?=
 =?us-ascii?Q?OezA4AiORA4PS1NAYZo8B05gBij35IAiv3I/3y0bNwsb+Y3hBuMNKAbnBDQN?=
 =?us-ascii?Q?VugJtXlSiMs7qfeydEQf17w0Y40qKGqHY2XH/hcyuZ3SD5yyWmZoWL+fPvC4?=
 =?us-ascii?Q?lpavZm3fhGCHjtOCq6h00kR/ciHvfya4ndfLNUX7z52NjC0L3hmWolK/NXVM?=
 =?us-ascii?Q?fJhST90F1aOhAY7BWKb8ultP+VpqC2W8XywukbnbxFx3HJ3/a6HxMsFNSYJ3?=
 =?us-ascii?Q?doRrTnYjHjg1Z/KjZA90xjYsRt9ItnKc0XeD2fJNO3sLiZHccBeKs690I+0u?=
 =?us-ascii?Q?EuQwEj/XKiFoMCNI9RsGWhQJJxQqPyC9qWXttnJD2Os/sdVfuWgtXa8Fv4gG?=
 =?us-ascii?Q?ZK8brrxKPtflM7dDOpz3rDWT4ScKB+QRZZvFPKXehEsH/RVujwPOZskbtjk5?=
 =?us-ascii?Q?IdghqoLG8PvCTHbo/vac4uqmrUmMkOfDdK6ZYvlSH3aiejoNYa0/QAzcjEA5?=
 =?us-ascii?Q?dCR0kvF0hskDlIiXQI4S6HrTsgyeGO/frd2k5jO3HdKl2+1X6y1YBWPH6chK?=
 =?us-ascii?Q?xSykFHrOlVc5m4n5j118SepsWCj01mSnQPLuIAxc6AqpuPiHsBCmmnCqhq/G?=
 =?us-ascii?Q?m2RQKAZgknOpT/DmnFPybmeSeKPTkPF4iLpIkV3w6SAIblH8PaMonVPET5iz?=
 =?us-ascii?Q?tKoj+ZYw7SsQA51hhDObDxFwYrc+AtTQRoK3Tqj9tbyXa+p9MrEPe9/33gTh?=
 =?us-ascii?Q?cs4Sg1Et4J9scCx6q2wRehBycf4R2AeBGQQsh8JFuzGlgVLz4CpVvWEXeuaw?=
 =?us-ascii?Q?k4iWKXIpTwXjwLnkAtONtrIQqRYIuzM9X/wdp3yIKJWIpxFg0n9q3Tsz52So?=
 =?us-ascii?Q?UF+c8mpXU/IWS62K8ROTWUC9s8CeFWA773W5Cxjhk8a4DB3u1v7S3z0mY9QQ?=
 =?us-ascii?Q?2jgk5Hi3vz37R8tr5YbNGdFD7cMPWHl9Ap0zjpmNIUlfkuyXRcJSskcY+kzp?=
 =?us-ascii?Q?eXUTlBCjM6Ie1x1FBdwdyk96AWdDj3BR7aEQOto/xx92D1ZRsiFPTASDtvpx?=
 =?us-ascii?Q?NA8mLQIB6t3pSgijf+bVlfprYbLVP5bZpgj+6YfLdchj8OtwHad4QIlPnoMo?=
 =?us-ascii?Q?nvzehyAWcfjXraTiyhFn/QaXw9/PUPk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1FBAF798C22EA646BD7ABE2C0A4D2949@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d049bf79-3f59-49e7-735b-08da11c19aef
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 20:20:45.1622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15CgC4fDVY4Z21qjRDnoOPKLXyomCM0z/hwaaL7mJLD7zOnmg06ysxVgzMhadL9Gr7y6UkRZ/WYu/loVoITVcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2493
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290109
X-Proofpoint-GUID: DvF5J9jvUxO8ZG-EbtAL-xMZukzS91RR
X-Proofpoint-ORIG-GUID: DvF5J9jvUxO8ZG-EbtAL-xMZukzS91RR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 29, 2022, at 4:01 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Tue, Mar 29, 2022 at 07:58:46PM +0000, Chuck Lever III wrote:
>> Got it. Agreed, cl_cs_client_state should be reinitialized if
>> a courtesy client is transitioned back to "active".
>>=20
>> Dai, would you add
>>=20
>> +enum courtesy_client_state {
>>>>> 	NFSD4_CLIENT_ACTIVE =3D 0,
>> +	NFSD4_CLIENT_COURTESY,
>> +	NFSD4_CLIENT_EXPIRED,
>> +	NFSD4_CLIENT_RECONNECTED,
>> +};
>>=20
>> And set cl_cs_client_state to ACTIVE where the client is
>> allowed to transition back to being active?
>=20
> I'm not clear then what the RECONNECTED->ACTIVE transition would be.
>=20
> My feeling is that the RECONNECTED state shouldn't exist, and that there
> should only be a transition of EXPIRED back to ACTIVE.

Audit the places that check for NFSD4_CLIENT_RECONNECTED.
Some of them will expire a reconnected client, some will
let it transition back to active. My impression from Dai
was that the server cannot transition a courtesy client
back to active in _every_ case.

If you can demonstrate that in every case where RECONNECTED
is found that a client should be transitioned to ACTIVE
rather than discarded, then yes, we should get rid of
RECONNECTED in favor of going from COURTESY -> ACTIVE.


--
Chuck Lever



