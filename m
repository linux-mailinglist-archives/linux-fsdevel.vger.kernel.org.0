Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F2479E927
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbjIMNYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 09:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbjIMNYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:24:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22A119B1;
        Wed, 13 Sep 2023 06:24:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DCnDMo000719;
        Wed, 13 Sep 2023 13:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kosfv2VA+JGm21MlfjdmLGz6QjpuX8vTrBzHfT/Hr2A=;
 b=nkatKJsN+4qcFHFSjtjSdPf6kxzcrdWEJMyDN2Rmfdg4hEx9UeYKbip0oO5F9xMHVPfS
 WlLdCoDDzXTVacThasHUFXeH0gUSSlsdDSD3YGs62R8nhs15TyGv9SvYK5tZrlfOZ8z7
 7DJyCTsz01SZmfh2GvPvPPOc8nPF5ivOGQ4Gr96NzFysaWjlPSaMoHHlExf/qxwm0/xF
 c4ddyKYiZlWtIuLNLfWzA+gTH37XBTA1COTU9LbZHMC1/0aW0dU4R0u3k9AHrBcIeBNU
 0Z8r9jx4t4s8faCMjtlCzh+hd/S2WsbEJaC41sGoV2RWEthYWvxRGaLKQv5Trp1SeBX+ qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7h9y3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 13:24:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DCflFh002291;
        Wed, 13 Sep 2023 13:24:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5dg4hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 13:24:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHZt+krP4qZZk+LaLEr6NDO8KNHzh545kDRHUWT6vfkiKbMPRsLsWUQAx0LIg/x4I3L8C5tzjfj7QwUONaIpcjA5AtJQY4q1AzN9ac9mA7BTXqWLRWsKeORAnzIzzyZAwWNqvEP/hql9QDNXhm4fbfZIufFpvxt26jrlJ2ff1pfpF2KOlqlHCGX53Q1uRlcd6MMbXPFBYGMXOT6QUHjUKYIteSnObCVksWziQjZXJsa1CuX/4+eTv9KLQNQ3JoiUdaFuXyfNIZ3t1WD/2wUBIFAtljKO+8C7KjA21grU3qxUEY5qoFnJ6m+sKg2zG2FhD1Z2D1yq0wc3BVljbrQZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kosfv2VA+JGm21MlfjdmLGz6QjpuX8vTrBzHfT/Hr2A=;
 b=S2XfoT0gw8YEoGK5C4kSehB5PzefJV4IbAyM4MX0DF/z0QHORXTy3u/Gpww8JZeSAxblI2VTR3/0hw9Fzix1jOVxiyXIPv3P1S8mqWhFFXj9oxQTrlXL1qqO80RB6UREcGA9iNYRvjgN4DdoWhHqUQx2B3/OusLIKN7fCOaH/Fu9q4MB+OTRrB7W8X1d2/+naTvxszpiPGqIQZCs0obuqo5vlcRablgN4wTxRGvB9Mb2lRo4R4HQqbCpowD2l3SLlrOvthvb5pd86nfv+iNoRH+q0y1eDAItN/gsnhS6uwSeyHQfq1wo1aLJwov+xSYmEFGKqqmjvRLj5663REIrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kosfv2VA+JGm21MlfjdmLGz6QjpuX8vTrBzHfT/Hr2A=;
 b=tmsO+hyOhUdAZBatuxagOXVn46zgsZlJ0pz9CKf98QTJGSMLqv24333nSyIM8ZtZGM/RQYmdRmdQyBuqqVn6HDpagHpzuvZjp+x7lgVzroIr6jpDbw9pxuP/szTl9xDM2KjQVKnLoLcVCjo6pfbO84Fa3CR4DorJgbthDHTpazs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4800.namprd10.prod.outlook.com (2603:10b6:a03:2da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 13 Sep
 2023 13:24:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:24:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Alexander Aring <aahringo@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
        "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "teigland@redhat.com" <teigland@redhat.com>,
        "rpeterso@redhat.com" <rpeterso@redhat.com>,
        "agruenba@redhat.com" <agruenba@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCHv2 nfsd/master 0/7] lockd: dlm: async lock request changes
Thread-Topic: [PATCHv2 nfsd/master 0/7] lockd: dlm: async lock request changes
Thread-Index: AQHZ5cOn7tkzYtpZwUSOE0ZF+eMtN7AYv5UA
Date:   Wed, 13 Sep 2023 13:24:11 +0000
Message-ID: <6BD25133-2712-415D-95AC-93E781AEA77B@oracle.com>
References: <20230912215324.3310111-1-aahringo@redhat.com>
In-Reply-To: <20230912215324.3310111-1-aahringo@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4800:EE_
x-ms-office365-filtering-correlation-id: 94fde6ed-2726-4b0c-55e7-08dbb45cb78c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wOvV2rjqNvx/ehpHWlM1+iX7443fAVIE2EfrfzmwnVlwsnnkqqiaXY6DXN7GXl6nCioWPLBcESkKHYGlx7nwJb5l2YRCKaAZ+0Vr2+j4m9JNtXkAGe/it/K78qxHOCo2tUIJjUCUhjMWV1HP25jFr0EXNjKvdqIU4Pq306+zOQ1dQ7BdoOU9Br3oNq/q+rSNzZhIB/VgQQ6AKJJcTZvDOEWxw6dbms7ryRhZlEG4wur2yefXeeXFPsCPvT2g1+bU0l7Hbbh6ZiOlePDpaP5eawxaHLGkewSi6hYOQX57wkGysnA2FGgEFCJN/sbparYXbvQSa1LQZHyPn+8n/Guhs9sjCrQkBVNLTHN4tiMl6rv2bILvZfb/V4n3raaP2aA8VE8E5FnP5PcCmwinqJomEdofAoY40d4z+z/ahLnPn4of6DO3wOnjSAv9fNJgEPXq79RkbMal0ix0RA+F5QxcNHY8RqiTKXyS+eeaPmiyqh2cgoAacby3qJVCTU8aISsqCFZMO7Jo5Wo7B7MpBX6NW+KVw/zzi4WecMm0hgRCedQyB1UUCs0nPW2Ddyw94xYS63r7fimUdWizh2vmVVrasrS0Bkjc5XcqRxCD+8zfYGI5b+HBZFuPc58b/ChOOo9L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(186009)(1800799009)(451199024)(6506007)(53546011)(6512007)(6486002)(38100700002)(83380400001)(86362001)(71200400001)(122000001)(33656002)(38070700005)(36756003)(2616005)(26005)(6916009)(7416002)(41300700001)(316002)(8676002)(4326008)(66556008)(66946007)(76116006)(2906002)(66476007)(8936002)(64756008)(66446008)(54906003)(966005)(5660300002)(91956017)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WIfMfDdN/4JkeQjAcBf/zbHsBqtlBUkRwPRyureZbJtVHZ/N7BfBpaS92yHg?=
 =?us-ascii?Q?eorLROEoESFM8tQLiR2NMLJi1ZIoK9cYxASSmEakgbKj266ffkUI9CNZbxy5?=
 =?us-ascii?Q?jkeLcmusLTQMS3ecCZwDgwiQWwGBwFEOt0T2Aqfm188q6/HqD6BTlouzTL1F?=
 =?us-ascii?Q?CC37FPLZJ2Tr1gxad80LDmOx/a+XBGNekU63O/s3yVp6TDZB28UmMA2qXjhf?=
 =?us-ascii?Q?DS0Fm3u+LKwLxKuuhJa5s7gCn1sYrXfdGd50lOLjwNl7NYcgrgIN7QB9efTv?=
 =?us-ascii?Q?XHpETU2MBIE79flB2d3L291W5wlh4TetIJJ2mRcgbGf71KXLsQd7Z3bZXVw9?=
 =?us-ascii?Q?bNDw0oCOv+6hF/KtEc48E/c+0OU87Izjv6iO/8TkdU4uwtnTLJxFXLXKdmDH?=
 =?us-ascii?Q?NsyUxCSR55AGP9YKHoyykMYRVp0fbQuI6B8lVWPRmJtyxAed7XK4X/i1RNix?=
 =?us-ascii?Q?m1NuBlslSmNohXPtx8W+R3uwEZxb+d9d/mDkMaaFDtyn/R+POukpXK1KV/a4?=
 =?us-ascii?Q?OcOegaSOqK3AiOsDyTVsqNYs+Uq0/zHz4pnGXPwVpUtEpJYaIL1scIWLxfaM?=
 =?us-ascii?Q?iiWJkA5GdoC8SQNwj5BeO3YS5K0UHH6Im20fVwLOhOLHWfqH42W3A2OWNsh3?=
 =?us-ascii?Q?JWwNvYyPCJuzJIGc/A2c87Tk74r9mSjaj8ghsGAuAer/BQEd1QOpMyQm4cng?=
 =?us-ascii?Q?OZ1oGdEpFCHB1+QmIQ9rYbURU9bUv9ss5jJtwMz6qwwbl74Fdm6NCdus9DPF?=
 =?us-ascii?Q?U2AU/6L+UoCj/ok0y+Vp2S0XNUr46ehQ0xZh6q/Yo6totBCru9RACwTuiVbx?=
 =?us-ascii?Q?TRT/k+m0KNS13hmhKif+cI8NAGSSt9SjaLEC74NcO8GP2wdRpVflWjD3f124?=
 =?us-ascii?Q?LUYLWss5uzjOklG+NOvb0+cJRMdJMFhj9oNXQXcZ0GkV8YiaCm6jGuPCOh23?=
 =?us-ascii?Q?pldpVqxvB7x6rGn94QXuripuGb030pcLZb0e7npTDX16YjumL0UlNgpAIrXJ?=
 =?us-ascii?Q?1U5qQ2D1o5jpOXCVsBWiNSmcuEt5YwZTMuOMJm9T3uZ0ipQt8OCInqrG4vVJ?=
 =?us-ascii?Q?Q5AERqpuDiNCKV1b2i2gsJCSiuGN+cdg+OC5eWLCM1RS4ku+YnMRzcNizSnN?=
 =?us-ascii?Q?AtdGv48jqHd377PhuwkAuSvHBhsmGNJSj4GQxEWRfa90qc9wp8+k5KrzCOyO?=
 =?us-ascii?Q?mtb8QpjMf2301CjViz43Aqbvr0hbfUVf31RpRu9VeQUfQVzZhJxKuvMQ9IFy?=
 =?us-ascii?Q?ujA/Ma3DuQ8aTVn98dqfAbmy4bYw5YeV8ax0UzNTEFf4ax2aUoPJc3XUdFwa?=
 =?us-ascii?Q?8WGgzpAbjwxtwhQQV3P85qwCGIBUnl6Tjhc+wzm1eAErvpkhtRnOrG/elWZj?=
 =?us-ascii?Q?E1AVn+0kVfizQlyauoui4Up02Tazu6bf/PARqSmnz/kdE0vVLWOO3YsAXyfL?=
 =?us-ascii?Q?WVSzJCjyEqr60xPYySNUf7TSCnBCvjJwHcQ3hiO+hfpl86uLfR6HUp4n4L4F?=
 =?us-ascii?Q?bo7D4VN23MS7eAHP2kmkHp2dLM/cewUS9P5uv8COE3Lfr6qJAZ8SXBqvOWS+?=
 =?us-ascii?Q?SrCeGSQShQ2Scwa+PujSDPvsVYYOVYVfexC2LfJ75cvp58jiskK2Fko2jxUC?=
 =?us-ascii?Q?5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0D739824F6F874D8B2F800F473553EB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3NnqWRSS0no33/FW4wgnefA+8HGIg+cYxqGfud5vb/2KzBm2EwmqnMlqF44vlh5QUjsqIlZY9HeIpCOYzNAPYwwcUsMZhSH95cZNswu3c/becmBm+kSweenD21laCuHcWJxZM0XQNVKm8s1uH1NssmCpaRDLBE3kiIEcULLqUApnLIpvmpSMDgTnDUPxMh8w/BzctzOZsJ5WqlFguP5gaQMvtYuobvmtKgWaKf1rsr9BCZYh3gJfU9RO1U8o2xoIKwqW8BfdFOLcBjorHxS6VpxOhPxi1/cC95uBfpcKQntLUka9sX3iGeeJ7eRbBZFIGo5zNSr5nve7I64k8XCwiPmO425l8it5Dzk0TXF1Wlo842Y0w0Jp3Z+bFAtD/pfqh0S9CLgXN/HDBFng9ZEmU5KXeADWqGMtfbz0zKRyH1g+xdAZxeYadzHxX9HyRWyd7ZrMQodc2zXd8afDZ4Z6+83cj4iQmMgdIWdRkAUrjaPUQI77F3xCQnufh/hlMbwc9jYonMuEYQCvsUTtvFBOyA2ic4iF4WSevsJpyi8xiqw/8iwKBNU6GzOeh/rO1vQkdtJHmPEg7nCLtt7DQeU6pLafsL8oeSe4lv8xoZEHASJZ83iKRzCV+oxj2HgVwBa3lDpDrxjYrxi2yrVb5aVCfvp+dvUHH5XKS6NrcCzdcnZMpGvJnYGqNNOLPIKXAU2CElDTowVU3NQ0hvLyEuE+lSzU9ELCmRZ3myCkJOBEKlSBT56+jmWnnypt8OPQm5uKnn3R7ajAXV/Y8cneKHKZoit7fvqB7czG9Bdu/WC6Ab+L/lx2SFhmDqqrwewO/3qjZa83loGXz55HB3t0UnSozxszu5CeRjEVTfkMvDIfaMkGKbbcTttTesqGwu1ilZfL+bY2Zr4HjxkQeaE0j23ajQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fde6ed-2726-4b0c-55e7-08dbb45cb78c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 13:24:11.2131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMMGZ5P5s3rDZnsbsSX14Ri79y6whaY4TipcBfQw8xmfqV4kEo68OXdgjpLY0cBbS9I07XEaHVOBEQd5iD3XNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130109
X-Proofpoint-ORIG-GUID: b6j986GQ2Ns3JM_dJe8LyehTNB9hlCVI
X-Proofpoint-GUID: b6j986GQ2Ns3JM_dJe8LyehTNB9hlCVI
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 12, 2023, at 5:53 PM, Alexander Aring <aahringo@redhat.com> wrote:
>=20
> Hi,
>=20
> I sent this as a PATCH now and drop the RFC. I got some review back from
> Jeff Layton and hope I was successful to follow it. There are still
> issues with lockd and asynchronous lock request but it will at least not
> directly crash when somebody is using nfs on top of GFS2. The issues are
> related to cancellation of locks/lockd decides to drop nlm_block for
> some reasons while pending request is happening.
>=20
> I did not change more documentation about the asynchronous lock request
> functionality to not confuse users. In my opinion there should be more
> documentation about what you SHOULD NOT do with this API. Otherwise I
> think the documentation is still correct.
>=20
> I will send a follow up patch to fsdevel to change all users using
> IS_SETLKW() to use FL_SLEEP to determine if it's blocking or
> non-blocking and send it to fsdevel as it was recommended. This will
> just be a grep and replace patch and look what happens.
>=20
> - Alex
>=20
> changes since v2:
> - remove B_PENDING_CALLBACK paragraph from commit msg. Was a leftover
>   and I forgot to update the commit message.
> - change function name from export_op_support_safe_async_lock()
>   to exportfs_lock_op_is_async()
> - change flag name from EXPORT_OP_SAFE_ASYNC_LOCK to
>   EXPORT_OP_ASYNC_LOCK
> - add documentation for EXPORT_OP_ASYNC_LOCK to
>   Documentation/filesystems/nfs/exporting.rst
> - add newline between function name and return type of
>   exportfs_lock_op_is_async()
> - remove f_op->lock() check and mention it in
>   Documentation/filesystems/nfs/exporting.rst to only use it with
>   filesystems implementing their own ->lock()
> - add kdoc for exportfs_lock_op_is_async()
>=20
> changes since RFC:
>=20
> - drop the pending callback flag but introduce "lockd: don't call
>  vfs_lock_file() for pending requests", see patch why I need it.
> - drop per nlm_block callback mutex
> - change async lock request documentation
> - use always FL_SLEEP to determine if it's blocking vs non-blocking in
>  DLM
>=20
> Alexander Aring (7):
>  lockd: introduce safe async lock op
>  lockd: don't call vfs_lock_file() for pending requests
>  lockd: fix race in async lock request handling
>  lockd: add doc to enable EXPORT_OP_ASYNC_LOCK

I've applied these four to the nfsd/lockd tree for v6.7.

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/


>  dlm: use fl_owner from lockd
>  dlm: use FL_SLEEP to determine blocking vs non-blocking
>  dlm: implement EXPORT_OP_ASYNC_LOCK
>=20
> Documentation/filesystems/nfs/exporting.rst |  7 ++++
> fs/dlm/plock.c                              | 20 +++--------
> fs/gfs2/export.c                            |  1 +
> fs/lockd/svclock.c                          | 38 ++++++++++++++-------
> fs/locks.c                                  | 12 ++++---
> fs/nfsd/nfs4state.c                         | 10 ++++--
> fs/ocfs2/export.c                           |  1 +
> include/linux/exportfs.h                    | 14 ++++++++
> 8 files changed, 67 insertions(+), 36 deletions(-)
>=20
> --=20
> 2.31.1
>=20

--
Chuck Lever


