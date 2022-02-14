Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019A14B57D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 18:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356069AbiBNRDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 12:03:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344510AbiBNRDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:03:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B704E65170;
        Mon, 14 Feb 2022 09:03:10 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EGl74H003324;
        Mon, 14 Feb 2022 17:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DBcnfFOFv5kWUWz83uOnBftjtLuD/rHyArF5Z4q23Cc=;
 b=JvuRD6Kj3qW4NvEPnM5jfO0KpfTsVML/ngFVYf/dO95yOnJih1h7dlAxb6N/Ol1Y+ukP
 viwYgqXXD9XOTVu5QmvGmBGHwp+U4TJKroleC+aczkRgrgGt3skfmSMFVhp38Kodq60v
 QJ9IUtZniAY6yD9gAYqvXFnEQxjNczBT8Q5Oj4VzlDhFBBcYl67WFMDcxFBoA84zmn5z
 WxzqMX47kH9IlilmqXGyxWAaiQC6L2qxO9/LgMcO/NPqPqSW9oOT7IiaIvjZ+8K5ntuQ
 Eyl+G20k1sAP3QtiE+L/3Zz9FEsFCiCgfZ7+h5som9kGG4MquoBFOaUkhOG15zENYdZ4 gQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63ad53ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 17:03:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EGu2Oq031336;
        Mon, 14 Feb 2022 17:03:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3020.oracle.com with ESMTP id 3e6qkx0pee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 17:03:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7j14E/56U5+8OTN8UXtPmIUc0F9StQh7NVWwDcn7TTfaLM5TD+ofH6Io9uMbBIjTDfJkKYZOlymGsqtQnesOpUdd3+BtfU3jzgOVfd4Y9oI1swGP1bMIyVMiNFU0XNgkud3EkiqLKpqL5hAVDjRtSQjsUGg1lp4H0AfzI5Y5k2DZMy++TcEBlPwaLwOs5J28a6TFY7BM3jcrvxw3wEVPVsK5Y2o3WHOQM01hziou7zc9Vl7l2RS8ui/5QrizniqaFxY41GE7TSS3/t58dXbRoz0SSxIXLsAydVT16elnQPS+M2EPMfMGKPMyOyUf7dOPUDAH0wSi4HNoMUaAL62jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBcnfFOFv5kWUWz83uOnBftjtLuD/rHyArF5Z4q23Cc=;
 b=mKyACRdTTzwfOCB9Bvof4LEYtt2+fxPJ1O2Xl1Pp7r4MCdi4V98viYaR+GswIu0Sk5QTzeiBElaD6i0qPEbXqggXg6ly5WytTJS5ZN2X8VViO0ocG7wV1OGvrGj86tSAbneVL150tUD19rLf1eoAY0gEC28CtJtL1FvXwaC0OpxY6GQAy50ze+wfwQQu5IDb/RkZHuyGZjlSPHsiypqQc39LheSigsBBNVeijL++3ifGSG5UY+SO9dDlxNYoamj8E5+SsuvDYkvCn9h73XaKdiIcn3QwKUXCDqX8NbOolgYQmMn/LmDCRB7PVzgdmomx/mnp165YG35+U8wk3u9/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBcnfFOFv5kWUWz83uOnBftjtLuD/rHyArF5Z4q23Cc=;
 b=dzhDLXtLwvS9uV8zTUoVlcL0/97IGAR+E6nieMaU+UZTuQAOXipRNI1uU5j8kZf/JaBNTIMXvBe6EmRUchwXEgX/zfgme18p1PHfbNGJuM+EFZqO6d7GtVPXndSNrVwuLxK21W7T8tguWKAnus+D+ddrzXtOSRjeDjaugvcof78=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2880.namprd10.prod.outlook.com (2603:10b6:805:da::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 17:03:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5902:87da:2118:13dc]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5902:87da:2118:13dc%6]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 17:03:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v13 1/4] fs/lock: documentation cleanup. Replace
 inode->i_lock with flc_lock.
Thread-Topic: [PATCH RFC v13 1/4] fs/lock: documentation cleanup. Replace
 inode->i_lock with flc_lock.
Thread-Index: AQHYIDwrzqKEY4tcHEWv0uOS33CT7qyTSPsA
Date:   Mon, 14 Feb 2022 17:03:02 +0000
Message-ID: <8EF5C08B-E6C9-4B3D-B26C-1088B0130BEF@oracle.com>
References: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
 <1644689575-1235-2-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1644689575-1235-2-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e49741ae-6e7b-43ca-83e0-08d9efdbdc92
x-ms-traffictypediagnostic: SN6PR10MB2880:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2880BADBC5AD994D70B2630E93339@SN6PR10MB2880.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: znTSU2l9B511qqRFx5CavueZMrrcusjWRTC8Jo+bGkXASX+NRmCuvQ+JhPx6T5UEBg3WIDMf2tQsKkzN2VVh0/tBQhZRJLAHH8KaTM32BVLWxbl0Z+nd9ufds/PHumZQ6Ixurhqo3od1BIkKDT76xozZ262DzsNeaJBswAvM690qpa60mCCzid5S/O9MsNn4i7VvZOd+FM6Z2GYFIWpH4DPAlgu+i2+SE9p68VYDnvUursufaMg24ZjOmUXSEQ3F8HdEKjY+ZOeFKyB0akZgEXqfb8adugTyrf5Rcjjk56bjfH+wbZVMLNCItG870Lj6i7RtJrcrnCtOfJpwAWV7BWvawtBlXaGeQyxuQELCDP50Ry3j/8rYEhQhhlXBTnuRxcrSl+NUxsXcoNJlnXGE0h5tyu24nR7SsQrMbrsfX3Iq1TqIrMWuTems5e5bzis+PPpg10QqQtnNHC8AQXI+ISAoh0RC6iN/PWcwpHlxoXoIKVv4n7PBv73FB+8FlYeKPRcBwYHuXcC9tSwe9ltdBzw19SV0rjvAvcWhbKvk3y4jEhi2vkszd8+mRyIH3RmEgKxUbsamybZY6DUionBWcBa9d9cAxrQ9iA3Vu+3BRYzWppbBza+/sj5pIUfko+XCWPY4TuO5xjVp+YoxnzoRfU8iF7NEb0NZh4rGAoZ1NAkWB4YnvJOXDUHYXpcz2ytW7WosSJJSmp2WcBM/WwWfQmw0Mj+Ryl9Myz7smiU8r6lGPPlZGhJIAwCUyl8zAxcy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(54906003)(76116006)(110136005)(4326008)(91956017)(66946007)(66446008)(64756008)(66556008)(66476007)(5660300002)(2906002)(38070700005)(86362001)(8936002)(8676002)(36756003)(33656002)(53546011)(6486002)(186003)(508600001)(71200400001)(83380400001)(26005)(6506007)(2616005)(122000001)(6512007)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6l43JdPx82rsfxsoJHigTGMgTpVieAOqpHAX18xoiiUk2c1wzc0m9Mqnss+P?=
 =?us-ascii?Q?TUoyMZCPpColtSLNQKVpon5bayQRMoFsiGJ2CAq1ZEvLSNw5g6uLsnFWHXg0?=
 =?us-ascii?Q?stuXYT1qSnrUstPFco3KTu0ApdNgnXN9Yv9o6qDkoJ/q4WPi38/CWmy+/tUW?=
 =?us-ascii?Q?huyVdgRV3WQx6oybfcuxVwXyaTbL+WZnO+UzOgVKP6hMXb+fbiY1gvATiru5?=
 =?us-ascii?Q?gQrfXstS6xzJvkfnYRWWi8b+NF+h/73csehzlmC575tvRnhDmezyni3awAbx?=
 =?us-ascii?Q?0nENRQSyRT63PvHfByvEu6LQzL9vMoGD1vhXeZHop53FuhFvnxwe4K+bWaDT?=
 =?us-ascii?Q?gHcPJjSv9vPmbSY190QPhE4TF4IrJQzz8nWYhJxCUMfgaTVw8XPcZ+dN/l1J?=
 =?us-ascii?Q?GMjQMYafbyUmJv6YLnSnDcvBxRIUtmFLWaPBGbIqsFPtxfm2Cyb6WuUs9kJl?=
 =?us-ascii?Q?bap0gly+esJTWlbADFbd8OogHt9yS/iRpeq3Qkf2sUhSs34BTAOd7CQXV4DT?=
 =?us-ascii?Q?nBNkj73etykGsYi1KAg8UgtZ7QSY6K0Os0VOtqn9FEtYgE88V12Zll6E8cqk?=
 =?us-ascii?Q?H/x2Okj+KXEbPe0c7CHRBbuYf9jpsJ45oRm7kQu2tH5MLCRw6YDsVRnqAk4D?=
 =?us-ascii?Q?DcmO0jIWRBuL9eWk6YIbyN2fws+sR34giCgY44rdS7WJ61PlnfMbPbmpD8c5?=
 =?us-ascii?Q?PbMg8q43+3jqM3Yoag+OFMgqIyoHUOMn3loHD+RnKPZAgYOvcbcwiyilf77W?=
 =?us-ascii?Q?ODnvRCw5z3R1/RHmQekCgyEytWOih981iGod+t9te9W98/euU/rYf1nO4F7j?=
 =?us-ascii?Q?smztgkuS5I3uYOIEmRD5x/FS1D4QIh8cnnoWIF6tAsxCWVI1ThVAgwMq6xlR?=
 =?us-ascii?Q?XFIKfSIBojzdCIFSCI7M4LHpI/iZclVHOa5kofB1idbSxRJoIAMNh3P7q/wN?=
 =?us-ascii?Q?Z3AemPGNOI7DdWVp8lh6uN3dBX7LxXRgYcbdufaTqvYDASUpQ2BchGTLvra1?=
 =?us-ascii?Q?m5J4xaTg+Ckjn9fHFwphI7oaRZVv+PjEcgX2ImIrZXgtSMe870MqnDxKwqob?=
 =?us-ascii?Q?qsLJ3mUgUP1FSM50q170Eo7o15Q9fc8DxbosGZkEhBd6Ey6hc9/LFz1jMyfz?=
 =?us-ascii?Q?FS2MMkJ1RlnCOtfBG/foxw/rlTEdbTIDg7vW5c3UilSTkkVCWhpr9DVIL+sH?=
 =?us-ascii?Q?sOz43qrLomb8CPqYDtWm7TIJvxe4iDpcNzu9PXNrLuuRYmBEdUTaICsJGOR0?=
 =?us-ascii?Q?hwUdTAQIzWsh3BxiHlnVfDGR9NTDg59zh+P0GT768LFIdsfguUpaxwIajFFT?=
 =?us-ascii?Q?j7gH3WcTw2nB87qeGgbT4JI7HPHe5IDcs5PtYQV/kqkl6n9Qy5g83pk5ZTNM?=
 =?us-ascii?Q?u1fJHdt6aYG8MEi1iYdaum4jYjxne2o1QlvYR2i/ZXYvKrpTO7E/tYuIR90o?=
 =?us-ascii?Q?dKKU/tLMdB2G58gO3JHZjN2HIlwyrSO0mUurQ6hq8RtTdxU8CMlSxf0OqyHx?=
 =?us-ascii?Q?9lfe6Z89XEvi6wH2yQDPFBp+iTaPpqT+sIE42UiPLc6uAEJlLc36CQJVjrSF?=
 =?us-ascii?Q?9s28fvNgl11b596hq4VN4MAv5PwKaNmVlTaZZHc+kDbnwdYP4ZEnugRNNJVK?=
 =?us-ascii?Q?Ck46LiTs2BkVAGY8AOkIIZw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EDEA95A7C707044E9475AA291E3EAEB4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49741ae-6e7b-43ca-83e0-08d9efdbdc92
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 17:03:02.6476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0rF3aDhMuaPiciIPXeyFanmSj+mXxCSxAN+ImWhmuvXfOERl4QO6sFlh53+JksO0bKibm3TNizd3Ne80xqVAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2880
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140101
X-Proofpoint-GUID: pl9_lAywemoR28zJzDCOSTiv3V2t1lyb
X-Proofpoint-ORIG-GUID: pl9_lAywemoR28zJzDCOSTiv3V2t1lyb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 12, 2022, at 1:12 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Update lock usage of lock_manager_operations' functions.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

I can apply this one to the nfsd tree if Jeff acks it.

Also I think I want to amend the commit description to mention
6109c85037e5 ("locks: add a dedicated spinlock to protect i_flctx lists"),
which is the commit that did the locking conversion, if that's
OK with everyone.


> ---
> Documentation/filesystems/locking.rst | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesy=
stems/locking.rst
> index 3f9b1497ebb8..aaca0b601819 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -438,13 +438,13 @@ prototypes::
> locking rules:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -ops			inode->i_lock	blocked_lock_lock	may block
> +ops			   flc_lock  	blocked_lock_lock	may block
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -lm_notify:		yes		yes			no
> +lm_notify:		no      	yes			no
> lm_grant:		no		no			no
> lm_break:		yes		no			no
> lm_change		yes		no			no
> -lm_breaker_owns_lease:	no		no			no
> +lm_breaker_owns_lease:	yes     	no			no
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> buffer_head
> --=20
> 2.9.5
>=20

--
Chuck Lever



