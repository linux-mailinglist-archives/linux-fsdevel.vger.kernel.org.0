Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7645351E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 18:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348121AbiEZQOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 12:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiEZQOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 12:14:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EA16A054;
        Thu, 26 May 2022 09:14:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QEJwr5022893;
        Thu, 26 May 2022 16:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=q6kRF52p3gG0c5apKHBwzEyk/E06vHAjgCVAkjBKX14=;
 b=GkV1aumtHc/5Nu0MeOwGePxe5Vf2rXZpu3/yopo803NDglh7Y7HphjznIyUcEPRDOR/h
 sNu0RCSNSEmhXI7luG2Fw2gZvfAFspYAJm09tRrb/8P1ltGv1PlB60JPETnJyG7jBJBi
 1DJiCWK9Mtd47cZ2ZFWbTOraokkA78FSkyGh88XyiSaFVvzSJwalLZ/OTXa+yz793kL1
 //u3Uy985+oYCwMi1HOzZAeac6NFLdIqHmLpOS4tajcUqKZD4+hL+mHV+j72y9EMCmF5
 eu5/N6ioKJ2xCFTXsVSnvmrIP0VFF/EvLgShJldjXoXIl5pmLnzfEfBJo9mng6sWwM7u /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tc5ayb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 16:14:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24QG60XU018661;
        Thu, 26 May 2022 16:14:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x0x8w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 16:14:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsA4GgcwEd+rV5gAKNECtMRvgUdBMoO5RTG88t91+wnJEE/CK/euiNeVdMZMCJ5yHUTm5A8Pt0NDyMMmC+X9qwuFSaA+pxQOb0QMihs4l/gtyfWwittnSgYt85DS5cq++urBN90+1OOSu0i5tyNCu2Pn+U215PZVYEUH2ZK85XXciu2qvb6NbXjR56cv//OK9TXbc37eT0SX2agoeGDinBK/zXOwEby+fYz1+BdSZn3ynFHigQz1ZYXFiWdBxC4iShgit590nhoHQJe3KD9jOa5VuxH2OE7l/OE8e3WvUYf1pFoXm+4UndwPVO7NTEzOh6wfphHiN8rLwOdv4qnSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6kRF52p3gG0c5apKHBwzEyk/E06vHAjgCVAkjBKX14=;
 b=GRQbM62VloNW46d1lahKSSPXf76A1D8prcCsXytwuIfqC09bkyQs9QGg48PTVr6gi51vLttPBvMY8j4cAgZ8G3Dv8Lhokbm56iNvT+8S0pizLJl0VQEQSdHUb+s7AL7Kdl4oqipcemuGkyZfWFNVREIX1Nl6PW+AuxgqoiBfQDh4fN5QO8wyWdPgBDUC4vmcd11NGYw3y+vNWIm7+GriBsYXkjCddW4rQfwir/k9W+PNptP+z6Yz+y1w+766pmKlRBstIYjmPpFH0kse5TAy61plP4gwMw6AdmoFtCeD9oXtp87QPHBSDn1Yb8zCbLozBWE/sro2xyFlBygoiSvaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6kRF52p3gG0c5apKHBwzEyk/E06vHAjgCVAkjBKX14=;
 b=PcZp7vdlLKo410smr+bvRcnJyv2eDNBBvQvndeTcVvVGhK8NqXH62N1G6m7oTcMI7KawFk9+ccXArfFhWRYI6+pwpF4p8nMFN3QRuV4XZB1/aiyM1AalDDYJ0xKfxCSnKDCXxqzhRahFyu8/DfRkdBhNm0E4dDZTERdjL9ab8OA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1374.namprd10.prod.outlook.com (2603:10b6:300:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 16:14:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 16:14:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: reciprocal co-maintainership for file
 locking and nfsd
Thread-Topic: [PATCH] MAINTAINERS: reciprocal co-maintainership for file
 locking and nfsd
Thread-Index: AQHYb1mG98xdFVfUhkqjHkgdWEd6Za0xWKuA
Date:   Thu, 26 May 2022 16:14:34 +0000
Message-ID: <DD4D53AB-2C61-48C8-B1D0-C50874910AA0@oracle.com>
References: <20220524103154.10827-1-jlayton@kernel.org>
In-Reply-To: <20220524103154.10827-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59f9160e-87af-4bc6-594d-08da3f32d2f0
x-ms-traffictypediagnostic: MWHPR10MB1374:EE_
x-microsoft-antispam-prvs: <MWHPR10MB13741583D8F475EA7A004E6693D99@MWHPR10MB1374.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lq1AonDkHp0Ky8EIjMeG3oEGlWnC8jSUSPP1ehRFFvHckkeActG8wnp819voUOFhvMFKh7nvTD2Hc2xa+sRYUeBfx51eBC4wOsQQhcR6rlsQF6eeS4XQCsatSAa2Kr3DsD3BWmbR7Bu0lfgCSUxtV54yeJ8PgN+gBSLtoKGQWW1l3mnQ6us8x+jUIUQXvJtkudtG4x8zOZOQzG9K1wxO6xS/Z/VWo1VZXTKFJNWc99uZgEs3JE7iJ1sTYw+hLCj/xra/fybg6zsJ+J0MSr2hu54BqxYjjeW9FV2RYT3YJh8Ue1W7PoCwb0wBux16/gqiYevY7bs0VRvtG5V/+4bIQW9+rBd/V8WLIeLbeQriZzPSql+2ddPlRKG51igEkdMvd2YD172D/LQniWqghcAfRpqPQtgkCRkPW80haQpPQBxUSYmxebOpCqw6wMK0eVPEFrDHe6yXh1Q39CZ3Gf9YJC0SGr7v+dIuiSuTplFMhuyLgSLHEO9w9MutOi/zpmBuxBajQDKKkNd+ZTJqFYqy+fv9qYa/Hhd8B0P+j/rqCuTxuThMAST6sn7haMukGAwsegw9IoqzkmivCBNx0MUjJJmClVSi64cf3I40Fj2k928NubrZq3FoLxCIETJOjDeZ8vUzTw4l/csRoTfLgE7a8tp1M95bsNBmo4ekdPuBmZaFoxju9SS7AWI81cvBlws7RAQgIBGpseSWL6j2qL4RhhMqZPjiWSEwu+/2FMGL/eM7HSe4IWEkbIl5pOtk3B74QctsFAcq9X5ej/OuG9v64Tacy2Quti92YnAjClypSln7HhftuoxA2zjWnYYGWVtq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(122000001)(186003)(2616005)(91956017)(8936002)(2906002)(4744005)(33656002)(508600001)(38070700005)(38100700002)(86362001)(5660300002)(26005)(6486002)(316002)(54906003)(76116006)(6506007)(64756008)(966005)(6916009)(6512007)(83380400001)(66476007)(71200400001)(66556008)(36756003)(66946007)(53546011)(66446008)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Afk5Pn0ok7kqSmDUgY3kPLzu9mPdXDcE1VBqNNf+pSKTC3qJTWcqs52sPB0N?=
 =?us-ascii?Q?dyoFTrG2hQQlnh8CqtGyUA4DAih/S4pxsWY2JuTfBeVmzDz6MHzZYr/jlQcr?=
 =?us-ascii?Q?CLCCwZxMRSemCe8KYvaM00BUPDql+dKIni6+EAOsV7wPiXCuv+nwmmKUWuSB?=
 =?us-ascii?Q?U3zLWOowbpPn387EUhTrNRKwXF5+g9iA/+0Gwsm7ozn2FHOMn3c23k/2tTyq?=
 =?us-ascii?Q?gQ1ogULK3jtd6Q+yDmHoO5uYqdZtdsI8GyqnlozZOkJ/SOf4EzcaxbKD1x6A?=
 =?us-ascii?Q?bDuULfinOvRYWisVUQhl4h5bPwjnU64p2a9jRRChG5VnuzL9ChVrTO6gEsN8?=
 =?us-ascii?Q?wKbFRaygOlznw+bc763raNtG/jh6hyZh1PWS3wgJMO2giSIiUC9ZTrvc3PiL?=
 =?us-ascii?Q?ZAzHpzS5aSZ7bXxQUd6xfidxq1rz34pVp7cN0QbzRNULpDBMefp+FvEFPGl2?=
 =?us-ascii?Q?EJVGej5kyur5ZQSiAAjJjo81bWsW9tRSV0KiIl8i+zX5vgQ/nlso+dX+M96K?=
 =?us-ascii?Q?WkWNT+cWAV3aiwCEN+2IryUvBm+IfbLioWLVrFXFrJN98Gel4Zw2PO9yzBZt?=
 =?us-ascii?Q?xqh2Zir3vlEa5GUkTPcZEG0VLoPRoXnU7zQ1h5kN2uklF5/bDylL+pN1bXPZ?=
 =?us-ascii?Q?jkcANX4ItW3+pBHPN49PCHw7MN+whNtILBu+pp0Fyn2SxPv0VtLcAf9c5GUD?=
 =?us-ascii?Q?KXQqQXRMFBq+ESMf2u1ObIhqCJcgSunjknN7CG6AeZZ4E7+pFRs14LNt89Vy?=
 =?us-ascii?Q?k651NZct3Kqbi+Wl+jwOl+KglF/2N9qsWcgCYrmvwqiZN3nwhn5YdNa2jt1B?=
 =?us-ascii?Q?tGlyRLptXdl7BsolkI/aeRem5Je3AiB8TjH3tnlC4eGMz8oPJX2bzLmgX12l?=
 =?us-ascii?Q?b5eNEnMniHj23q41d4rYNnAmRZ3+P998i25qoL4h4kUNPuy4c+Mc99xjBbHL?=
 =?us-ascii?Q?GhzDkRcONOeE+fVM27DoZzdl478v/GIYABl80p1nbNuVf+4u4XyY4iMqQwzq?=
 =?us-ascii?Q?UedS5pLftUjbdIu7Bt32rs5AzpE+wxDDySIRTi1vWS/ATHMP3pqUyPZuMT+6?=
 =?us-ascii?Q?2sUx5s157DILsuW1mWYeQF8QyRe6B6ayM+RpDiuRonvRsbKxOCDoRxwD3BQl?=
 =?us-ascii?Q?nPXVM9LxSj7NW7jCt2fO4/LWnHCBjll/zeic8sfe0VjYTSLdUHEHb1KkyVsL?=
 =?us-ascii?Q?G9H3mi/oRkuWFo7goZ/0DDNemdUj0+R3YwLZg+syqFzgjNd+Fp+iHgVx0ljk?=
 =?us-ascii?Q?TCPZyn3I8ZKigkcIAxG4GV193/UAifqujodmHdgEPaDjJMlM1W0+B+m/Gt0S?=
 =?us-ascii?Q?GQgt8qx9/SK+z72XQdbczWuGY0O55dWp3/E3KE1DOPWgFAjh9KogLPgwZX6q?=
 =?us-ascii?Q?ipv7/8DD/YKabWlrRcVXcQM2/Fc+0WIICcMOxiHBr438fsMztSWZneUnrEsb?=
 =?us-ascii?Q?1/L0EQAdryxTupEhT/4SEGcW60dXycnlrJem3ci6jedIdtTDdrTaQll3wRcG?=
 =?us-ascii?Q?oMrD5O93yotS7Z6UhlIiSI2pro3l+/YdOGYJQImRG24TQkypt/CmHkmQEBvy?=
 =?us-ascii?Q?c6b7JUyyeLG7ppkZXiiuBKNzr0dA7IsPmHvKZH/z/+ZWL+Od4DAJFkDfEMmu?=
 =?us-ascii?Q?FYjoiuwx0631vqy1atwNnYzxsFaYSxWKqmFX/Cz1poy/241Tn9076a2Cs4pa?=
 =?us-ascii?Q?Fqwmb8fEkPeZhAA4VvNBRBuO/HQ7D4UyKbkeck1gOf/9uuAy3lQnvtm0x4tZ?=
 =?us-ascii?Q?xyCxnn45H22NeDmBjOL00JDDem09KNQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6108ECAE088A7448FE7230FC67EE506@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f9160e-87af-4bc6-594d-08da3f32d2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 16:14:34.5915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQnZxzOxo1t6KyZ2dJ5s1bCETRUYpcXLjxRkqdclce2eCmOcsvt+uUIVw8ULlPwQbZ21BnA8nDgbtCta8ggKfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1374
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-26_06:2022-05-25,2022-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=843 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205260077
X-Proofpoint-ORIG-GUID: XnO5eV7BFogxGdrfdyyz0JUgM2J0gqEk
X-Proofpoint-GUID: XnO5eV7BFogxGdrfdyyz0JUgM2J0gqEk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 24, 2022, at 6:31 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Chuck has agreed to backstop me as maintainer of the file locking code,
> and I'll do the same for him on knfsd.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> MAINTAINERS | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 50eeb7e837b6..397a97913bfb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7571,6 +7571,7 @@ F:	include/uapi/scsi/fc/
>=20
> FILE LOCKING (flock() and fcntl()/lockf())
> M:	Jeff Layton <jlayton@kernel.org>
> +M:	Chuck Lever <chuck.lever@oracle.com>
> L:	linux-fsdevel@vger.kernel.org
> S:	Maintained
> F:	fs/fcntl.c
> @@ -10653,6 +10654,7 @@ W:	http://kernelnewbies.org/KernelJanitors
>=20
> KERNEL NFSD, SUNRPC, AND LOCKD SERVERS
> M:	Chuck Lever <chuck.lever@oracle.com>
> +M:	Jeff Layton <jlayton@kernel.org>
> L:	linux-nfs@vger.kernel.org
> S:	Supported
> W:	http://nfs.sourceforge.net/
> --=20
> 2.36.1

Thanks Jeff, I've queued this up as the first commit in my for-rc
branch.


--
Chuck Lever



