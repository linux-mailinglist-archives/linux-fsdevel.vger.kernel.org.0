Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C1762823F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 15:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiKNOTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 09:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiKNOTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:19:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4E826132;
        Mon, 14 Nov 2022 06:19:51 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEBprwE016399;
        Mon, 14 Nov 2022 14:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Grd1WAXzjoeYhsSt68/iHzuNjOYWQIqyx9Z8qEar9ik=;
 b=dBRv7NDpoRyWK4gYJY4KRrwAptZ9CCJ998YFonnwimJ38vkXo7Q3b3xHzmvErG1fA1rn
 3wcDKvw1JUvOV7yZwp++5yvVaSLmCwdlEyA6GxL/mOUjZwMeB/FLgfkPTntsjfw4SGXe
 U79kva8Ri24EDUkCMEaDyjQ/3//qJ7yhHpA4Aiypmx67TQsyNH6lGDoIc/CmPkgri/xF
 C16MpUU1SdhxUnFo1oah1qBEf33/IolKqPeVlNJqqySQcJ00S2r9Nls9BFXtb6UlA4M2
 ncSNMSby3P3O553/JM2zACNerToOHEpCVWRhtUuEl7o1ZEovUUPnXdeR2Igwa40XqKjn xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku1t3j1bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 14:19:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AEEDtYw015562;
        Mon, 14 Nov 2022 14:19:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xa7qy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 14:19:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrpq7spY+QQ5e22Z6CccjJIDHOO8hdLwSV/T+vUWKFnlw6Rj3uRHePBWH2pgi8vaZqB5bIBWqhPVPs5nZZVFeHxx3/CPMC+2GgsjgYAxnoFvGRvMUa3htWnLCGX204jTuD/Wzet1+uWBuhX3I3C7+C7iQpB0iTYNwLKmpwV2FTtagUqL7caXRmL0VmocCTOtY0N5+lTxCPeeV4iizd2TEGbsovQEPL4qzuR0aDNdOH2M8rQx8eA8XVy7+HybFEXUSzzcXZ3IzWHQYGejo5OF6nwqac5NUSxadBbbzfV5+elewcoYkSBEl8AFi7k+ltpohKEaYtSxtBOifGUWGTyrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Grd1WAXzjoeYhsSt68/iHzuNjOYWQIqyx9Z8qEar9ik=;
 b=Lc3pJMAC77+/0uBRs2HyjaZEOrrnSr27/vVLxjYKVM1RqfaBa3KhW4Dx6PRAMYrMC21zgbVC+pA2ObjG8G3mP7kxKbmhOkQ7WwVZ/JmJTf4xhagXJtxIk5izYLDEE9/hsb3qKi0z9tp6GaNvsCxkxCFMOVpy9/+dZMNgCxIWBwmhrYarbfh+4mFoHkzm8eIMyj2mMA2482qcar+4lhd2Ah6Tdus/ac1mtiJeDamCgp65UfeqP9eyeb5BQwJbYr5QqhFLgxssYwJiElvKSg0sdJsrUmxN4OmoGo4yAKw3w46UA+hX/kfnfMEE4rGqf9LmGAu7NkHBP9qstcoLX+NH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grd1WAXzjoeYhsSt68/iHzuNjOYWQIqyx9Z8qEar9ik=;
 b=vQD4Zf92XhsuGF+4sID7n9hFhz/YR8w7+RDGRe6upAtYFeZD+IDInas2JKf5eAAQKbHrUs7l78ezgQJl6tU+i82NvJRqC0CmI02MSYWTIgIcVRmNW3c1fGqY5Ba0OnZGyWQRhXI6BhNFvK/sufmnk07vriUK5gPVbO+sIJxcfPY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:19:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 14:19:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     "xiubli@redhat.com" <xiubli@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [RFC PATCH] filelock: new helper: vfs_file_has_locks
Thread-Topic: [RFC PATCH] filelock: new helper: vfs_file_has_locks
Thread-Index: AQHY+DKnkOfWSJV6H0q8ZtCbNKS1p64+d+KA
Date:   Mon, 14 Nov 2022 14:19:44 +0000
Message-ID: <D5691F8E-98BC-49A1-AF86-1FAB357B8468@oracle.com>
References: <20221114140747.134928-1-jlayton@kernel.org>
In-Reply-To: <20221114140747.134928-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5004:EE_
x-ms-office365-filtering-correlation-id: a2131833-28d0-464a-f23b-08dac64b4716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: az08sJGvTl2biGUWvzR9ZgCCrbNnAjwJfve8qoXQFG64E/zcM3ucj8ecvc1HDhB7audBPIUpUX1mMqoQWTBZoOcY5TKYZKRYHbw9PO1gDvWeFo4lXyuyvuUynDai7+z2yP1teuRTOr6suMuI7Z8iboNRUl89NhmFwR1X5zeauPKAfiWTcYbSfh66ikQWXikw/dALpyf+dswjtOTZnaARl4rFvgmJFqZzTb3NwYXUSmmNdDmDfiQVcL2DFMbmPWfu5NQEG+FQQhKrufBHSfWP9f+j1ab2IzyE8rSOIUb8ex+m75U6ngvCSErEJWwUnY+cvlOPcloMUE0l05Dfj/4nhgd5uGvD22fXtcpRfvajCUUF3r1pIGMMBFOpUAzu75N4+8KdiWWn439pJV3VKw98dINyZiXl4JLoBJuryQhypvyV0OtMM6PgL/NFc+lRILgm903suvDfNHyoL8fzImvM5VN5ZdL/6lWJDcplJoJLve55DPKXIvw6voa1Y+xZRg0X2Bp0cmT8tC/ozC1+205tBNsVkJnnYY61t4A3mUfvJ9uR3n04/NunPF5kAETx7xcJHurJRFCz5C2e8izAMbyYEJbpowRt4oM1iFfdwDTNiWNaMF/VkBSKz/+eGsPxwyDjE2lsjCskNRJWTstVDoCWlyyBoenvXf2KJMAyumDupC+1ehAsw6t1f+JFt7UobxHXqMYNg5aYWIdI16/SR3Hx9ZpHjUiOKfcaGgJFUYSjdn5qgHkmjIhqf7VWK355VUrgL6XgR4GhzC9/SkS0VRpq/e3+R+70ji6gXp2+8NU05qM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199015)(41300700001)(478600001)(2616005)(6916009)(4326008)(6486002)(8676002)(66446008)(76116006)(33656002)(64756008)(2906002)(91956017)(66476007)(54906003)(66946007)(66556008)(36756003)(186003)(71200400001)(83380400001)(5660300002)(53546011)(6506007)(86362001)(6512007)(316002)(26005)(38070700005)(8936002)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1qpy901SQ5eCkve/0ryoKDtm+2L0F6GJO0VJ8C6IbKMO0IVom56wFHBWl6SO?=
 =?us-ascii?Q?QPoRSCCt/Eej/f/hbhgGkdzg6FCh+GynFkRebsCpvG+1QIhRr2r/GN6FQhNt?=
 =?us-ascii?Q?zsTQkZ/tnE2d6DuSTa8bDkvEA3Q1sq+9TpGrcq25eP+7aFTudoocPM9X7p//?=
 =?us-ascii?Q?wn57BcljaCOJejddoV5VdgAlb91g8rR9ZaiP/D6FbpbsLbe74mDNmJFMY38d?=
 =?us-ascii?Q?K0XPLmgj5D4d1VTA56Ub11qSKWEOvGXKvrNBz8VmpH3c1NOkyeHcHZDaaHpN?=
 =?us-ascii?Q?39MMFnYQchmVlTh6BIp7IZinhV2dHu1ngFqKQBEUujlGk20bt/m37ShN6h6y?=
 =?us-ascii?Q?KwCeEtLggDEzvKGHTbFcVi3UPBCILc3Vw/62z5zc5nrs/NuUuon9TN1c/+tI?=
 =?us-ascii?Q?vkPU9IHbNygs4qnkb1R8CcoQRQzdL7RZaLCg+9qnmp7tGhHfdx+TvkhrwdTN?=
 =?us-ascii?Q?5Hymw3274OwxPdEj1Xg6/jE4i6VDQSdgYRoBG21bthT5yHpHU/pbvknqq8Xy?=
 =?us-ascii?Q?x0WoLXvsQTf8iV9C1hzSYsRRd6/ASmcdyzy6pTXgi2ATrSX7sAQkjIBxuTvr?=
 =?us-ascii?Q?jhMwADYmFgSVNlg0SLmv3iB/q6AxEZ/KN64CM3Ink+8pNhgI1gw7TaQYLdh2?=
 =?us-ascii?Q?8Cuu0Cj55tmBCQKPULIdmjGw7bde3BjaVv5CZMVuQVd4jympuIJimtrMZ9xe?=
 =?us-ascii?Q?l2QgzUi3YsxTC6fBsPEz43mLDhXw0yg5CaPgKnif571KSQ3A5EeVqHC8OGMi?=
 =?us-ascii?Q?mV8PqNJe8+q9IIbC9bWsltQxPmnr7V7PWza2ok8I7iLXuExxifLYxSS4GPOh?=
 =?us-ascii?Q?TkCDMxgrzqS9uiwvbQ+bI5kbJ83ztKYfptFUUUqETn6BHNxtdEW4A+pytYGK?=
 =?us-ascii?Q?Qeww77M1TdmIDb6jq0JZhA9T+4cJXD8v3qlCbtuiGSbQFBROcc+CUznDMPVa?=
 =?us-ascii?Q?J3DfFaK/WazzBV91i9CZ2TRgAbl0upftDKrq9yjlw0BCGBz8JuzHoF1ScLIH?=
 =?us-ascii?Q?sqFnCwsiiCmMOilSt+b12Ktf7xj9hLt3yrNn2gXG4mAr3ZqgSXAJvpN/RcDW?=
 =?us-ascii?Q?uB5pvvs5XOE6atcaRa6O8ZC9uO9dush3FzlwFndFD7SjWQlddcOl3sMdEB1D?=
 =?us-ascii?Q?dwTItCBa1VY+S6ZxbpEqWpY6co9X1/56RGVlUtFVEm9mEagSu31DD2kuukaH?=
 =?us-ascii?Q?f0wDAkiHF8JWpduENgMnAJR2VeJwrqSVwk+BWQLAGzl7gOLSaPc3w03xBfAG?=
 =?us-ascii?Q?ltisJX5UnqHBXnnLQYqR2wwtBtlzUZw72pHBitaCi8m/+fce1Ly97VdJ1E/H?=
 =?us-ascii?Q?sPiWq9A8pcQgpUCBVD6kTTKALMduqsCztWkv/H3n4wBWdfuY0O2N3twih4rN?=
 =?us-ascii?Q?ok6q+Ltrw/FAczm6DdFmHTq0rkT7dmzgSvhAVrFEnURvgc/dW6jh9lnbNRhm?=
 =?us-ascii?Q?hRd/HBWayoEfyJsYjPdrvf+65mqPAv+ous9fxKgXzIIDy6Hdz2ksERCfbA0W?=
 =?us-ascii?Q?EODjZ7MsvGQaV6HI5/RXeGbVepiCCfubGbXRRoHhsTzhPhcw0cipuy3A5Id9?=
 =?us-ascii?Q?Un/olSEleSsSh5JgbSjLmrq+24nAeMtS+u59N43BKP8R7TDw0l7jGEcxFA+L?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E040E157913E64297C0A59D5BACC821@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d0H6D2Mpum8k7MXGca97wzL4UMfit5A3fBpI4Lj0wKtMDlwrbK12vaKtLAEcX1a5d0zP8I8fXSH4m4GUyb9NwkymnEThUQrgYhthdifc/z06HKLDZvBjjKtZ0lyq/azHCfGj9N0dF+86Mj22vazY/tM+ADgWkiULcBmdNYKnu8hb87EVl/8htS2AoGVWjSKz+6+Prw43sQPGxJM+ag5JgdgTmrbIBbPYBf4IFX8AWzmDZ/50QRKcYAtkKWoqrE++vGJyn6pv4WbHlP9Y+SvDqaAK0v1dBIBVY6xLdcnxqE30TsTDtclbitdaBvAtP/7drorSK0N+PLZ6YG8tEOVnaoyHmknio0YCL6VBOynsuptlywme3BBhgFuxsvj6Aa2CdYtAwObHPyCfJVBI0t23E/xtpzrMgk98QkgPmqntOSyJ1km1KLCv3tTbL3quBeSX3Cn7gwyxfSFREWWONGKQtyIKMBCC920s/gterZshKBhfFF3R6sNCw/Ym8h+VdjOgeIr4i3ZY+F3gi1cGoDcuu1mdlsPCCkMJtxFHpcmjeEsgcXbD1bvsxfg3y1Zoz7NcLzzfyv/sW8eXc7lb+ckfbnaPemD99VJhBvH7qc/YKRj28PtoABs99K5xOg6/KkytfU6eyZpocHuIhLnHewjjKQjZwXA3g+hxQXpGowVrbm4E9BswhSGxtmMmeF2sHaoBTHdxTYE9yHRhCpNVyUh4qP9gOgeLavciqQjcuPYeohJ7F/pbAfxVfFl8fcN9sItWNE9+ta6RpvWWkqRSGStwKnOGvmJi9EazVV0UX9Dpk0Uo1XU7L32hkM//EKGrrP3HLXho1A+PP5RlS3FSwAfoifa3rTmKBZ3dtjRzg71Gp14=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2131833-28d0-464a-f23b-08dac64b4716
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 14:19:44.3722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/nxflOJjnhLsUe2t+aiaERgG3FsgR5Q+ohPVUgCyyC3SqlAPL3b/h47xQ0cYqWOA/kpZDaK2c8LCmmx8GjjdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140102
X-Proofpoint-ORIG-GUID: nHbLmOaWUZ1XXvgMy2EUEjSdwOkwuoY9
X-Proofpoint-GUID: nHbLmOaWUZ1XXvgMy2EUEjSdwOkwuoY9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 14, 2022, at 9:07 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Ceph has a need to know whether a particular file has any locks set on
> it. It's currently tracking that by a num_locks field in its
> filp->private_data, but that's problematic as it tries to decrement this
> field when releasing locks and that can race with the file being torn
> down.
>=20
> Add a new vfs_file_has_locks helper that will scan the flock and posix
> lists, and return true if any of the locks have a fl_file that matches
> the given one. Ceph can then call this instead of doing its own
> tracking.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

LGTM.


> ---
> fs/locks.c         | 36 ++++++++++++++++++++++++++++++++++++
> include/linux/fs.h |  1 +
> 2 files changed, 37 insertions(+)
>=20
> Xiubo,
>=20
> Here's what I was thinking instead of trying to track this within ceph.
> Most inodes never have locks set, so in most cases this will be a NULL
> pointer check.
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 5876c8ff0edc..c7f903b63a53 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2672,6 +2672,42 @@ int vfs_cancel_lock(struct file *filp, struct file=
_lock *fl)
> }
> EXPORT_SYMBOL_GPL(vfs_cancel_lock);
>=20
> +/**
> + * vfs_file_has_locks - are any locks held that were set on @filp?
> + * @filp: open file to check for locks
> + *
> + * Return true if are any FL_POSIX or FL_FLOCK locks currently held
> + * on @filp.
> + */
> +bool vfs_file_has_locks(struct file *filp)
> +{
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +	bool ret =3D false;
> +
> +	ctx =3D smp_load_acquire(&locks_inode(filp)->i_flctx);
> +	if (!ctx)
> +		return false;
> +
> +	spin_lock(&ctx->flc_lock);
> +	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> +		if (fl->fl_file =3D=3D filp) {
> +			ret =3D true;
> +			goto out;
> +		}
> +	}
> +	list_for_each_entry(fl, &ctx->flc_flock, fl_list) {
> +		if (fl->fl_file =3D=3D filp) {
> +			ret =3D true;
> +			break;
> +		}
> +	}
> +out:
> +	spin_unlock(&ctx->flc_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(vfs_file_has_locks);
> +
> #ifdef CONFIG_PROC_FS
> #include <linux/proc_fs.h>
> #include <linux/seq_file.h>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e654435f1651..e4d0f1fa7f9f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1170,6 +1170,7 @@ extern int locks_delete_block(struct file_lock *);
> extern int vfs_test_lock(struct file *, struct file_lock *);
> extern int vfs_lock_file(struct file *, unsigned int, struct file_lock *,=
 struct file_lock *);
> extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
> +bool vfs_file_has_locks(struct file *file);
> extern int locks_lock_inode_wait(struct inode *inode, struct file_lock *f=
l);
> extern int __break_lease(struct inode *inode, unsigned int flags, unsigne=
d int type);
> extern void lease_get_mtime(struct inode *, struct timespec64 *time);
> --=20
> 2.38.1
>=20

--
Chuck Lever



