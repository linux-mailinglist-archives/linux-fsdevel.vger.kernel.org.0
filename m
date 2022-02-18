Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BC04BBF75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 19:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbiBRS3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 13:29:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbiBRS3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:29:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B1486E02;
        Fri, 18 Feb 2022 10:28:50 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFx4Uc023673;
        Fri, 18 Feb 2022 18:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0h4bNna406sajHnQyyk/J2WnX3nizNE0EQtGAVMcEgk=;
 b=ZnU/lrFkmIpw7RtKydVz8D+gY1TqeqbzXqA9UccSmLTlO0aa3Ng76lRVjxnRvfN2FGp5
 z2xY9mP0+GmGWlIU/9WONSIjj9/OGG+ol+FkHCHiGTIDqSILId2DD2M3qTO938w6Zf8R
 LBzddlaKHXq/3Lgvcefj+v0jQGEShtrxH4IT/5gzqxoyPtT3gHmA0OECi/8apjX5Bg8N
 Uxc4iZNkWNmaG2slleJ9a6ZGYueyqxntk49dve1g06Dmq3huaQ4UCff3xZw0U3vMdsoH
 oWKM+KdHzXJVU4ZAwBAuO9+ji7UXuQIctzgpmEhGyv7D/GVaEqohT7Yxqog4ejbE3gzC RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nb3suwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 18:28:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IIKdj2039467;
        Fri, 18 Feb 2022 18:28:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3030.oracle.com with ESMTP id 3e9bre7ury-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 18:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay29TeYqtNnabpaOydadap8lk6uzesKKnGyGmIGBfpixphBt2PGV4wMVRgVpNPYUy5Yml5PA3yr6FJ81Fo5lO438km9MeLf1QyYbwDSLDX3lIEr6HZyntQ0StDqF69AIM6+ZA/6YJbJ0fDVAbashSO3EJqOxDv4b9ytIyJoMpLyrY5QwXoa50a53zFoete44uOMbqL+dx0KGkq4IRWsp3v9teuNWoM3HvmNVNPnZnmy5LeuF6yqpEyIkHi7KYEGB3UInxFyKtsJr36i8xqi5KDTqgHHnif09/pblhBu7jDqGe9Sezi4RLhuFRT0ehz9ML22UhmyvcRca0GyYO1S+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h4bNna406sajHnQyyk/J2WnX3nizNE0EQtGAVMcEgk=;
 b=Edrjy5380FGLcTha2ZgTqToKcD3cCxtnFdEqLt9bJNGJuZqR9o7G4EoqSQyctGwBZtlgayrCyrUBI2cUM+RzPlAuG++D4FmNHjjTUNdNkie/9DluwR09jhpH9gJ68egd+vV45nProjyDP0p+jzdaVHX72IBCJXbv/uDXnQpHNIo/BIizAN6blx4kmI3Wm4tKSdWx40xTiHADnvADkZYZ44EOyWpQshYlOr45ZXgIOJInleNy7c3m862VtCbN/MeZArXo23zNSIOx/gQTq0GfRKSpcmn4KhS+SiEaG5qjbfMUKppzcQ1Qxc8AyfHoZ33S6bbNu3g7gqv1Au64GAJRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h4bNna406sajHnQyyk/J2WnX3nizNE0EQtGAVMcEgk=;
 b=I6pS2i95U4WpLJlmHjkSWayzz/8Vxvl6QOKcb4602C9uTplg+fp/qB8FLcfzM9yt5Xg1G9dGBQIxg9l78t/Q4KPlcv5e5UqZRMKdlkGQiTrGy4OhBob6VtOE0ueu66PGD+NCwKjukKImmdAZymni4ZAsVEeMxdqlC84cOILGIto=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5617.namprd10.prod.outlook.com (2603:10b6:303:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 18 Feb
 2022 18:28:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%7]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 18:28:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v13 4/4] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v13 4/4] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYIDwrUbH4vFbDYkeTHocB/S7pFqyU304AgAEXOACAAGm+AIADQtaAgAAHIwA=
Date:   Fri, 18 Feb 2022 18:28:43 +0000
Message-ID: <DE32B98F-FFC4-479E-BF84-5D3A3FB48311@oracle.com>
References: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
 <1644689575-1235-5-git-send-email-dai.ngo@oracle.com>
 <FFA33A13-D423-4B15-B8D4-FFDF88CFF9BE@oracle.com>
 <b76a9b30-89d0-c4ab-a1c7-0ca1a1ed6281@oracle.com>
 <6553DE77-F4CA-4552-82C1-46D338FCAE44@oracle.com>
 <4253d364-324c-c993-c15a-e75896f1d38b@oracle.com>
In-Reply-To: <4253d364-324c-c993-c15a-e75896f1d38b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3057da48-e6d2-4d0e-ea44-08d9f30c7e60
x-ms-traffictypediagnostic: CO6PR10MB5617:EE_
x-microsoft-antispam-prvs: <CO6PR10MB5617872CFEF72934E3C149D793379@CO6PR10MB5617.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OJXAa3xkg2tzkAxOnWwcABB2sVHWa6pqZidvfi75XczWel49aS9AYMz9BUG6qB+Sv1L2Cc1TDYxgyQDoX5W5t5kVh0hQLVU4uZaM7PtzhpB4MR5AFT6q4HEg6teqq69CGa8c3U5q9fQWuNHpQ2Y0K/js98bryMAzEd35ZQertpAeRftAPYkdBPKeRnDWUYRiwknOpsi4v+4z4DtBc/PgcIF7ji5jPNf6N0gMXtNrUCiUAkMiF9gzBktNOe5zplGAwi2IE586vSKPb69s/Oq1930DkqO96vpnnsS2OF8piG/9v6TEYcVQrAMybiWzRyrxXxpFXLDPNDi8N1JyAzZwBy9+VBF714cs8u4J0U6P8IihqrYk5FchT1AnZpSlrr0kCUYWXZqCEB/mJQRF2fM1JsQaNR5woF/xF6fmx2+hpWe80oqdh1b5l789PYj3Rq2yEUKOWVvulVHtHp1xPfSW6UqGs3WrmbOuwbhYValT5gzzrl3YRxD0cTecv22/dJ/Qps/wgHPZInl98LiwE3+J1h6UqiezCnOYu94vx+M0Siomul89tTO4W/GFw5L5k9jDKksFOhNOvCTMsiW+8h3FrZ8MDCoivgdnANSRsX14+H5l2ke3C2ikoq7S0xfm4Jb3Iq+53amkmevpsT9DR/Fpx6m+l7gL+1QhhYKI4sHx3JzC3O5na1OTcYWN7WB9lqEGr1SCq2VTnhsAMH5fYHEEKCvPuT5uYUlKGRM0AlW/SBAJF4CZRe8ooEIdKhp83lem
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6636002)(37006003)(86362001)(54906003)(38100700002)(38070700005)(8936002)(5660300002)(316002)(6862004)(4326008)(66556008)(66946007)(6512007)(66446008)(91956017)(2906002)(66476007)(64756008)(76116006)(122000001)(36756003)(6506007)(53546011)(2616005)(71200400001)(186003)(26005)(83380400001)(33656002)(508600001)(6486002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G0NxipTbfXTjZmo6vhVXwxkHKPMKBh9h8B++PQMzxd3Brvu1+coaNYFDbceD?=
 =?us-ascii?Q?noXnLRXr6Mlv3kzQP2JOLWCzUvsOHcZ3P23qlUnYwx5pBXzKQ8PDoviEZ1NT?=
 =?us-ascii?Q?stLezkcs12cNMQdR5qeBWRBNQKYBeQpXJW///saG6uaY8a/z3y0EtazmTnUr?=
 =?us-ascii?Q?yKbU5H+FPr9f0WxOOOIO5++B9CYLWrqLXVuyigyaF1gnOFoAaEA9OnS7VnK1?=
 =?us-ascii?Q?xqNshXwP6zjzwwzL0n8P/Q7yJhqv7bMmCfgdmhiWYXRH79VhMiaBjGBqD4ec?=
 =?us-ascii?Q?dmR/1I6gftqyzbVsQxqZrbUgfr/niTVIp0zildUvHSCYFdjaXoM9FJdJZ51F?=
 =?us-ascii?Q?blVVjzlmclrQ8piwb8JtsaK5/gbIIgEE7xt0Pdd3WKNbKl+y9nKfFrenhySK?=
 =?us-ascii?Q?/agh7S6cmxqe65Y6IwACFaMJacQXj9YdXEiowyZl9tghV2p8EkGbMYQRxGQZ?=
 =?us-ascii?Q?aL/8PXG1kyiALum9dm9hKOX+dd8tttG9hSHGNemfoZb3vKowLdfpVbI0pKeN?=
 =?us-ascii?Q?dqrtubGJkDGxzcxSpQ6cHeltnLt/QIO0mINikNAXnofZcpJQZz4iNz0Deu7Z?=
 =?us-ascii?Q?Bb+f2p+C28Y3YwOXADvW18QtIiclAgaGifLzhxBcVqCS54GkK4qhRKIBXuQK?=
 =?us-ascii?Q?L80ddRosPPzMBue8Mhcci2ahaIpxDLnTUuZ6gUakr72OXdAJVRQt9pOwP7v9?=
 =?us-ascii?Q?bjX4eAGylDwoE7xrE1EnPZVwsO/4fx/GcaRgUKdCu4WJIsV3790h08DjRu9r?=
 =?us-ascii?Q?DmPnTv10Vv2HFsU856OxXGC0Y4ixj14j/F9ObpoYOH1SLxqIRNnmVzJqkisC?=
 =?us-ascii?Q?ATYCX8QJqDtAqb4AuOcNrp7wg70gJUlVaonS3+xCwbDtq/coQYNZRphJ1jeD?=
 =?us-ascii?Q?VlrCXbVcZd/ABocMBUA4EfZSJyh+5MGkhqjI0r5K3+d/QrWovrlMMrp6tidP?=
 =?us-ascii?Q?K06ZuDIUSwrLR15anPoeDZ5UfsVznzyOc9Y+quVOQyojRk2Zxk0rfVhmxc1d?=
 =?us-ascii?Q?uoUQhkAXGWUBHdN1rIKOXgxo28EcSD8AIR/LZmSWWOmJnEsUAhy8uTnI6a8M?=
 =?us-ascii?Q?+A7qgEYit4f//jLop2qQPMisIgd1RANFVDwADT5ur84uBPCw0VJ+VnifsS0C?=
 =?us-ascii?Q?RR+xy6Mm0EJfhdDA/nkMj1hQKqPB+HgP5PdOU2RW0cOuJJIqpYpEboxXqH42?=
 =?us-ascii?Q?D18isYQpQfChKVyRgZ030YZsonx4bZbmjcE/RGMcMjTYJew5842PXCkxuLF7?=
 =?us-ascii?Q?wGTMEVOQ24bWEAlcOekkJo93TasdF8/9nvN1FaePjC4LjIYzFLFVsp6/UcKG?=
 =?us-ascii?Q?bsJihblBLQDYCJOkDPQa22c+3fSbfetDgl0gtFjEnxYATRCbGSKM8GufFKGj?=
 =?us-ascii?Q?k2TuJYfNgRMuxC0my4+mYFXzlMZcy5869TvYb9N4ACyXu1fLZjEjW6Ls7/7F?=
 =?us-ascii?Q?bUTOo2AanSAjLzl4Fvm7WMUewUEjl/Zcd+HHFPHOB3/5+sk69TjhJ4FuNT7U?=
 =?us-ascii?Q?YoAABhUvzxmDOyb4ICYv1IaELLeUU5++5kL7L//8vMLzaikJSCdDIfRhaWXe?=
 =?us-ascii?Q?gEkATPQprt3yXUxqaxtu8YQ6enzTZC8mqOKRGWexXaqqYMfpuzPAL+jwLl4U?=
 =?us-ascii?Q?HsVNeMDXFZ9kbNOXP6MfmMA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41DD26EDB8EA624D80CE57CADF5429F6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3057da48-e6d2-4d0e-ea44-08d9f30c7e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 18:28:43.4136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+Kd99Lyb5BKxi4EzKBb7MfdkIRPBBDwtZMAethOwqooZDl+Caf8K+QX+1TyD4g2WZhvF8dsKhETHTptnQsgRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5617
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10262 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180113
X-Proofpoint-GUID: ZVWyoyQuuYCYy54xyA4amBBidCp59cLQ
X-Proofpoint-ORIG-GUID: ZVWyoyQuuYCYy54xyA4amBBidCp59cLQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 18, 2022, at 1:03 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 2/16/22 8:15 AM, Chuck Lever III wrote:
>>> On Feb 16, 2022, at 4:56 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> On 2/15/22 9:17 AM, Chuck Lever III wrote:
>>>>> +		 */
>>>>> +		if (!cour) {
>>>>> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>>>>> +			clp->courtesy_client_expiry =3D ktime_get_boottime_seconds() +
>>>>> +					NFSD_COURTESY_CLIENT_TIMEOUT;
>>>>> +			list_add(&clp->cl_cs_list, &cslist);
>>>> Can cl_lru (or some other existing list_head field)
>>>> be used instead of cl_cs_list?
>>> The cl_lru is used for clients to be expired, the cl_cs_list
>>> is used for courtesy clients and they are treated differently.
>> Understood, but cl_lru is not a list. It's a field that is
>> used to attach an nfs4_client _to_ a list.
>=20
> Yes, cl_lru is a list head to hang the entry on a list.
>=20
>>=20
>> You should be able to use cl_lru here if the nfs4_client is
>> going to be added to either reaplist or cslist but not both.
>>=20
> We can not use cl_lru because the courtesy client is still
> on nn->client_lru.  We do not remove the courtesy client
> from the nn->client_lru list.

Thanks, that's what I was missing.


>>>> I don't see anywhere that removes clp from cslist when
>>>> this processing is complete. Seems like you will get
>>>> list corruption next time the laundromat looks at
>>>> its list of nfs4_clients.
>>> We re-initialize the list head before every time the laundromat
>>> runs so there is no need to remove the entries once we're done.
>> Re-initializing cslist does not change the membership
>> of the list that was just constructed, it simply orphans
>> the list. Next time the code does a list_add(&clp->cl_cs_list)
>> that list will still be there and the nfs4_client will still
>> be on it.
>>=20
>> The nfs4_client has to be explicitly removed from cslist
>> before the function completes. Otherwise, cl_cs_list
>> will link those nfs4_client objects to garbage, and the
>> next time nfs4_get_client_reaplist() is called, that
>> list_for_each_entry() will walk off the end of the previous
>> (now phantom) list that the cl_cs_list is still linked to.
>=20
> Chuck, I don't understand this. Once the cslist list head is
> initialized, its next and prev pointer point to itself. When
> the courtesy client is added to the tail of the cslist, the
> next and prev pointer of cl_cs_list of the courtesy client
> are not used and are overwritten so there should not be any
> problem even if it was on an orphaned list.

When nfs4_get_client_reaplist() returns, what is cl_cs_list
pointing to? At that point IIUC it is linked onto a list
of other nfs4_clients (via their cl_cs_list fields) but
the anchor (cslist) is now in memory that has been returned
to the stack. That's either a problem now, or it's some
technical debt that will bite us later.

Say the NFS client is having network problems. So it might
transition from active to courtesy and back multiple times.

list_add() does not simply initialize the .next and .prev
pointers, it actually dereferences them. The next time this
nfs4_client appears in the laundromat, the list_add will use
the existing values of cl_cs_list.next and cl_cs_list.prev
to link it into the list that cl_cs_list was in during=20
previous laundromat pass.


>> Please ensure that there is a "list_del();" somewhere
>> before the function exits and cslist vanishes. You could,
>> for example, replace the list_for_each_entry() with a
>>=20
>>     while(!list_empty(&cslist)) {
>> 	list_del(&clp->cl_cs_list /* or cl_lru */ );
>> 	...
>>     }
>=20
> I added the list_del as you suggested but I don't think
> it's needed, perhaps I'm missing something.

We might even want list_del_init() here to ensure that
the state of cl_cs_list is correct the next time it is
used in a subsequent call to nfs4_get_client_reaplist.

--
Chuck Lever



