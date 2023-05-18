Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B261A708696
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjERRQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 13:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjERRQa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 13:16:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3122FCE;
        Thu, 18 May 2023 10:16:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IFLlEV012471;
        Thu, 18 May 2023 17:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3nm+jWSOr8huOUlryjPwCBGAOAtDYCU41bEivJuNtzE=;
 b=oK9KV1v2QrjyIthKSbx5t1n6vtDd5dTTo1W6YN7082ER8sy3J2ojqGH2NFjqHopVv5zv
 GHzqf0yhb4M549s3mWVNGdBUuhXaHm0y4sjA5WJ5VtWeedis4uag39eBS2b+eJDg8+c1
 GVYQsccHIzxg3L73a1HxMG6ZOmMDe3r9kRGCkGsiHtZzCI8Vbq22Iy2O0T93/VMDKdy2
 RumB4TsGzbNJuq8bIklQu0IaMqMWeveGDlqY5rGnqWLY/9V2C3nDKGgx7tHwGbRR9vGJ
 WxxjPcIQjPwx5+9Btbf4YBgiVsd73F28XsyoIXNPYD08J0wJDjKA7joL/Ek1flGMGrOk bQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpk2up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 17:16:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IG0ccl032121;
        Thu, 18 May 2023 17:16:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10d3682-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 17:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAwV5yzWNpypIc/+n2kc4T4FHu0R1hxSukFcG66+Je2yYuzkp2pMi4oXJmAYtooS23krYE0M3xAZnStmm/QGci39s40Cs4Gex+SeHpCCio+pj4bHUGDt81SEdli5i4YCpbVCBaGD8psAFFMfaJx6CiJQSFEzb3Yo2zJrZOZ+dVeqbWmUmjsYzeSkeQhfvJivesFtEcFMO9xFRgijeLectyASn6Ww4joftnsa3pjnC7/rxL587P5u4okMComnqgBvLEC127JywvxVYt0JPLwrYkju+3V53RLAZgGiD//YYYzKJpecFBfh8RW6MfmFHuNoMOXWXX+uLOLxTEXqqlhVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nm+jWSOr8huOUlryjPwCBGAOAtDYCU41bEivJuNtzE=;
 b=ibMGHuEDnCZwmdaoaZVT+v67TcY5nCjZd2T/S8RJ3JBHVKoIIN1RhqdtjdUuXItXjuqoOz6MgbFRSfqQyalxmw4bfgVzC+UfRVKWugBt3QNeLKsKQPj2R+Wey7izFRQZwRcEeDNOg6+IKnLkU42rqApZ7byS7qWa5UiIugVSmxn0tzun/Wpf7ueom9nn/AnCSErPpNx6LljE90UtESnPnJ9UE0D+oEeUjYltBtnnjytUXpKdBh4fddyJE+g4C4+KPACfDduruhcEoK45Jk6Lu5vRfcm5Yxn9iL+rveVZh4aVq0fqQMvOFNU4cH2ARk9tDO+c6XiRCz1F2tFUYkJVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nm+jWSOr8huOUlryjPwCBGAOAtDYCU41bEivJuNtzE=;
 b=lcE9c39uVfQB7Hh6EjLMbn+VG4HdLzrGJJedBHfEVJLi9KG/+ZhI4kxEg+TPaKJnYw5mIuaxNyjvDbhJ51i6kzny2q46hsbPLxQQ9VC17IcmpcxMvp7HFiHYpS3llg27bq+MfZwjhTejU8lCFjrP2PnuDM+4BeuZkgc1/OdCxDo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6669.namprd10.prod.outlook.com (2603:10b6:510:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Thu, 18 May
 2023 17:16:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 17:16:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] NFSD: enable support for write delegation
Thread-Topic: [PATCH v3 2/2] NFSD: enable support for write delegation
Thread-Index: AQHZiRjK2+pv1cqK90qCm9rFy+BQfK9gBbuAgAA/mgCAAAFTAA==
Date:   Thu, 18 May 2023 17:16:14 +0000
Message-ID: <C3B5A73F-2504-407A-9B62-A130CAA5E2C9@oracle.com>
References: <1684366690-28029-1-git-send-email-dai.ngo@oracle.com>
 <1684366690-28029-3-git-send-email-dai.ngo@oracle.com>
 <1B8D8A68-6C66-4139-B250-B3B18043E950@oracle.com>
 <21ad5e62-b3d1-2f74-d3fb-819f4e6a2325@oracle.com>
In-Reply-To: <21ad5e62-b3d1-2f74-d3fb-819f4e6a2325@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6669:EE_
x-ms-office365-filtering-correlation-id: f3f96f84-30b9-4441-7a54-08db57c395c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lC+DmYdVL4lDBWTePTt/9iUUfPN9JPPgNchDcdEQN9heq8LP7QNb56rW1/cvPE/YAQIgbZsCaaT+lH/qETVzJw6BWU4miODctLCQcAKFPCvap8G5rsU6QT3PqUzrUB01EBLGabWWn0agJdYUqVieLIPi4IrwgGDWKsGKdiYJOyuAqXg4y8F6lumEigepdpblvBvWay7kwWqwSnrB+91Lze5IWP3VGPfM69y5B80nQhRinFQfPiOPRm0OSFg2TuaUWlpMtowWpMdeG4WUW4nyYYjeE1xs+/oFVfflVbsO0Q3d1SaYDml84ON82XBkw5BTNWV/kfjoZ3p+P8EdOUEbgJklsy16OimMnoCdkT0XAHB3sMZEtapGNR9xcJ/k+p6zF+hfiesYNLVFtie4UJwMn9+x8CrjP4bLbFkzDyjceKtsDLXEGW3MxgKG9BMRo1pbFEW86xW3yR7uxiRpmnMi5Pm4hI7oVarUJVWvukxwJnXnHZKUzexTIf/FHSLRK34J/tNY/F2i2cYaws8FNPdN0zKPHcv8QoWgUdKkrXj8ZQfJEX9pkvTGXcU/ig3RgTPHN5ksHu7oXNvIjWKwSJeg/3HM1yoeKss1k1t8u7cNXhHKa+E8w03EEM+V2SVE9pgj8bRoGmM7Z3AGbbLpUWngHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(66899021)(71200400001)(91956017)(6486002)(64756008)(66476007)(66946007)(66446008)(6636002)(66556008)(76116006)(36756003)(316002)(478600001)(38070700005)(4326008)(86362001)(54906003)(38100700002)(2616005)(26005)(2906002)(8936002)(41300700001)(122000001)(37006003)(33656002)(186003)(5660300002)(6512007)(6506007)(8676002)(6862004)(53546011)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0TadyEDKN1TjEVODbo1w2iWECbFYIoIke49tDKPlkn1DC5zt6wHzVhPZVIyU?=
 =?us-ascii?Q?RquBhpS22GggH4kqLhCpnJwvbBgdd8zoL1TGn/646EvLLkjlb+ev5QgwWqsV?=
 =?us-ascii?Q?ztxON24Qk9oxvIMVzErAO6i2GzV7LEp9Lh0sZ85mkDTUqkGMl3jgkkSmCzwx?=
 =?us-ascii?Q?7K+wo7rw4NjxpYFEH5yGlVinVO2/HEMemcJr/NvPwyK7Lj4I/+IGDToG6PZ5?=
 =?us-ascii?Q?53wVWNQ7K0cV9GM5sPIHKs70HSoCrOYvZAr5ei7HfdLNeeggh6NzRCiz7GDW?=
 =?us-ascii?Q?6XP5rs51jfmf94y7dp+JUHz5yYEDQsFQkhbCVDLUk37nKLWa7vcJyqWZKm6X?=
 =?us-ascii?Q?FTJi+Rw7YyaB5THO2Zita50cywjz5NHMfSn+gdbv8DrCcHz6+IHCcJgsniag?=
 =?us-ascii?Q?pf++gtMunNA0PcI5czd/Hi8I23mrOB2hpQ3amv/2hdx81rJ7X7DwDiNFZ7an?=
 =?us-ascii?Q?75SaPsUz0ktWCbTAXZKsUyYft5fMPybjLdPO3ZzLzCcYBSYaEc15E4YEYse+?=
 =?us-ascii?Q?uZ9XWZqGg23v9Y1MQCo/xXhV3f00Sj1r9mx1ocQfeWxR+cP+DGOFwVfbOslH?=
 =?us-ascii?Q?7+EzfVO76dgFVNomRGNnUiwsYkCip3QXj0ZCtcAHHCMj0zBVkk5n5skuyiZt?=
 =?us-ascii?Q?CyDjtSmeBj23/A705gBV2fVNssR59L+dYZF2jPAZbECBzfInN2zPQKhE7VGt?=
 =?us-ascii?Q?9fQV4A5hhZ1MnJOFX9rEbVrAmF6yu4RYMA09Ll8V+4MV3KT6INq6Ojkzxjfb?=
 =?us-ascii?Q?dXHnxtgrtTqG3SNJTIfEVUUVQfpdUrAbGX2KnCYyZ/3T+5jfQmG45zAViDZx?=
 =?us-ascii?Q?FYgP8+dC8tcenKvzrFiY2mTHwd1iIJbmxT+70xrIRLus9X72h44BtBss296A?=
 =?us-ascii?Q?OPN5zzP1su4Ou/aPNxm0TsWsD9rll6wcgyLUKfKfwAoUFEEcszInYnfi4xTr?=
 =?us-ascii?Q?zsdn3cBk2JDYFgg0GOxnqzjVI6p1jZTM9fZa3yeGd/M3nxhf8p6j/czK/02S?=
 =?us-ascii?Q?aJmrTRe6cQMNuXE54vqUHEprTxvcc8uuH2M05p/avxnNPuh05FLz/WfAYxee?=
 =?us-ascii?Q?W96Plp1r+PqaTIqwICy69dWSVj02rKA5Uip6R9t/oD04LkfSwHm9rI8bAdOW?=
 =?us-ascii?Q?1Dx7a2SWYnjgiooJ40X0NfjZT4czx/7nFZ9XjCPKe3wVa6mNZ1syfh11WBtI?=
 =?us-ascii?Q?4XZwJ/zzfYugb6YPlJI2g9v11P88oSyKtZlF5QYId2LxkT4txo7X/aEeZduB?=
 =?us-ascii?Q?rpv6mcoR17tiASWeFfB4smUoR0xyjADCcTn5LC/4WJq7w1h9yAk87KqzR6Fx?=
 =?us-ascii?Q?wuVF9e5O1l6AGHR+IwDXMR9LZA7V1PJnEQfKjChKUYzxHCTIXCOqnJbqujYu?=
 =?us-ascii?Q?uwaPehkKrKIPZqY/2eAoVWQFeHxPIiG17ecW4XQyZSa6A0FGDF5UsIPMVVLm?=
 =?us-ascii?Q?mRr6Tkp9UoNatD8sdA1ypAd+9RUAKzSmPhmTHD2sCIL8R+E3nQDZGUC2pRyi?=
 =?us-ascii?Q?IqOSQetArZsfmSwb3LRgPh4aFxZYMG5Taph3WzUaeB3nJx0sgski2SE6CFvQ?=
 =?us-ascii?Q?JvyqKRe2cLQlWxcncygia5UG0Y0yVppzsDXdaL99nP9lks6MHizmrKg/lSEr?=
 =?us-ascii?Q?SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4F410A15027F04EBCB285FF9F2B62A6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DGShLKDqoh/F+yFVSmZHVKyRlhYgmeSVJ/01X2Q8EBypSgO3/Dj8fxWrf6q1S+IDJDhYU4+8VFEjg0i90C9l1cdO830AJsio5xd5pB7WHMLfQeWdsiOv/Etg2fwXVHDwdskAYI2JCSrReEBdxiB9yXbWxiS9mAVLVAbY9ip7ODgt/S7yNgSYa/bT4bbeUtCy72Q/59P2aFclK4f1PEfBo8QsYWVomFbszF3yi50dMBLm0QWI8Arr5qofrcvrjnf8YxmcRycA9a/wPR2Dw6u2KUKlytXccxbzeey65S2zttzu7hCoQQX6wnNSQ7lZlumd4GW0CXtzbELDQvv+HYvPWl2RKx6V6os7FOC/5NdLhvcRABJ4+ZstGomZsj1DEhFr142/kzOzBYaHSFg/19utIDm0+pBFq5snGYyXsbkLGP51UGxBhQ7nIJvTVfUvSC6LZraWKrVYTKxQnump+dXMJYFkg+fLwyg4bYZaxBFSA506iByd3Nxo4pase9UGS7aZ9smTbTUsOM21f5IqBfWoxmHOGb1LjzGszAqyG/L247pZ8dU56ozcNE5F/+rd2UDVuSZi0Mb57bwM+yrm080GFuDDd5CIyLofFdkya62HJPbX/XkHeCFfSAud/i1MF0q/rThaXgXp1AmNDBjIjGUzSFH5i34ShxeEoxIkdsCNr9vK5wqENKs3O9+oU3ifrx4X1ocz/obQz5rL8+xlJ8fVkLOFytNQSE/0EwK/nG06miNCk1jObQPEm+dnfW8IfU4MLAZFQ6HrhZC2Ufgd4OKCrjUNuKKulgqsMM60xhmIUTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f96f84-30b9-4441-7a54-08db57c395c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 17:16:14.5592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnFcxe62vlZbpOaFIfgaFKDIRnAb3W0U94fRmDHZutbu2bsNbmV13WlFXCJ1IOy9EP4ak4Chsm43CH4iL6bB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180139
X-Proofpoint-GUID: v_kTx2xCr99GAlwvTBKtRxzsB0RD41ln
X-Proofpoint-ORIG-GUID: v_kTx2xCr99GAlwvTBKtRxzsB0RD41ln
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 18, 2023, at 1:11 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 5/18/23 6:23 AM, Chuck Lever III wrote:
>>=20
>>> On May 17, 2023, at 7:38 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> This patch grants write delegation for OPEN with NFS4_SHARE_ACCESS_WRIT=
E
>>> if there is no conflict with other OPENs.
>>>=20
>>> Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
>>> are handled the same as read delegation using notify_change,
>>> try_break_deleg.
>> Very clean. A couple of suggestions, one is down below, and here is
>> the other:
>>=20
>> I was thinking we should add one or two counters in fs/nfsd/stats.c
>> to track how often read and write delegations are offered, and
>> perhaps one to count the number of DELEGRETURN operations. What do
>> you think makes sense?
>=20
> I'm not sure what these counters will tell us, currently we already
> has a counter for number of delegations handed out.

I haven't found that, where is it? Certainly, if NFSD already
has one, then no need to add more.

It would be nice one day, perhaps, to have a metric of how many
delegations a client holds. That's not for this series.


> I think a counter
> on how often nfsd has to recall the write delegation due to GETATTR can
> be useful to know whether we should implement CB_GETATTR.

I hesitated to mention that because I wonder if that's something
that would be interesting only for defending a design choice,
not for site-to-site tuning. In other words, after we plumb it
into NFSD, it will never actually be used after CB_GETATTR
support is added.

Do you believe it's something that administrators can use to
help balance or tune their workloads?


>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/nfsd/nfs4state.c | 24 ++++++++++++++++--------
>>> 1 file changed, 16 insertions(+), 8 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 6e61fa3acaf1..09a9e16407f9 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -1144,7 +1144,7 @@ static void block_delegations(struct knfsd_fh *fh=
)
>>>=20
>>> static struct nfs4_delegation *
>>> alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>>> - struct nfs4_clnt_odstate *odstate)
>>> + struct nfs4_clnt_odstate *odstate, u32 dl_type)
>>> {
>>> struct nfs4_delegation *dp;
>>> long n;
>>> @@ -1170,7 +1170,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct =
nfs4_file *fp,
>>> INIT_LIST_HEAD(&dp->dl_recall_lru);
>>> dp->dl_clnt_odstate =3D odstate;
>>> get_clnt_odstate(odstate);
>>> - dp->dl_type =3D NFS4_OPEN_DELEGATE_READ;
>>> + dp->dl_type =3D dl_type;
>>> dp->dl_retries =3D 1;
>>> dp->dl_recalled =3D false;
>>> nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>>> @@ -5451,6 +5451,7 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
>>> struct nfs4_delegation *dp;
>>> struct nfsd_file *nf;
>>> struct file_lock *fl;
>>> + u32 deleg;
>>>=20
>>> /*
>>> * The fi_had_conflict and nfs_get_existing_delegation checks
>>> @@ -5460,7 +5461,13 @@ nfs4_set_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp,
>>> if (fp->fi_had_conflict)
>>> return ERR_PTR(-EAGAIN);
>>>=20
>>> - nf =3D find_readable_file(fp);
>>> + if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>> + nf =3D find_writeable_file(fp);
>>> + deleg =3D NFS4_OPEN_DELEGATE_WRITE;
>>> + } else {
>>> + nf =3D find_readable_file(fp);
>>> + deleg =3D NFS4_OPEN_DELEGATE_READ;
>>> + }
>>> if (!nf) {
>>> /*
>>> * We probably could attempt another open and get a read
>>> @@ -5491,11 +5498,11 @@ nfs4_set_delegation(struct nfsd4_open *open, st=
ruct nfs4_ol_stateid *stp,
>>> return ERR_PTR(status);
>>>=20
>>> status =3D -ENOMEM;
>>> - dp =3D alloc_init_deleg(clp, fp, odstate);
>>> + dp =3D alloc_init_deleg(clp, fp, odstate, deleg);
>>> if (!dp)
>>> goto out_delegees;
>>>=20
>>> - fl =3D nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
>>> + fl =3D nfs4_alloc_init_lease(dp, deleg);
>>> if (!fl)
>>> goto out_clnt_odstate;
>>>=20
>>> @@ -5583,6 +5590,7 @@ nfs4_open_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp,
>>> struct svc_fh *parent =3D NULL;
>>> int cb_up;
>>> int status =3D 0;
>>> + u32 wdeleg =3D false;
>>>=20
>>> cb_up =3D nfsd4_cb_channel_good(oo->oo_owner.so_client);
>>> open->op_recall =3D 0;
>>> @@ -5590,8 +5598,6 @@ nfs4_open_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp,
>>> case NFS4_OPEN_CLAIM_PREVIOUS:
>>> if (!cb_up)
>>> open->op_recall =3D 1;
>>> - if (open->op_delegate_type !=3D NFS4_OPEN_DELEGATE_READ)
>>> - goto out_no_deleg;
>>> break;
>>> case NFS4_OPEN_CLAIM_NULL:
>>> parent =3D currentfh;
>>> @@ -5617,7 +5623,9 @@ nfs4_open_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp,
>>> memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->=
dl_stid.sc_stateid));
>>>=20
>>> trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
>> I'd like you to add a trace_nfsd_deleg_write(), and invoke
>> it here instead of trace_nfsd_deleg_read when NFSD hands out
>> a write delegation.
>=20
> Fix in v4.
>=20
> -Dai
>=20
>>=20
>>=20
>>> - open->op_delegate_type =3D NFS4_OPEN_DELEGATE_READ;
>>> + wdeleg =3D open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
>>> + open->op_delegate_type =3D wdeleg ?
>>> + NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGATE_READ;
>>> nfs4_put_stid(&dp->dl_stid);
>>> return;
>>> out_no_deleg:
>>> --=20
>>> 2.9.5
>>>=20
>> --
>> Chuck Lever


--
Chuck Lever


