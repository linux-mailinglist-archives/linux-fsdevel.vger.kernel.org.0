Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3D4D647C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348909AbiCKPYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 10:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbiCKPYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:24:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED8216FDE2;
        Fri, 11 Mar 2022 07:23:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BFEZ9b019569;
        Fri, 11 Mar 2022 15:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bfaOQyjDHPY/9uF/sK07kFxz4h/OLP9T2BByYY7cr9o=;
 b=U52m1GyPNtGPTJOGwkuO/7/I4bvq677og6qZBw6jvILv2OVNdLZKU0BdZhZIvVdEdG4p
 vxmgtsYv79kF3HSxNaJPTQ4tEHpY4fqyADuiJxfnx6xwRSyjJUC0RDIVsHeTJPcQIR0g
 gv8XZv3ESr/aIOoGzf9gZpCQqCFYWQK0t9jyBiwzZHEMqcXrpBbmPK9jhKYOFtb7MqLo
 YUniEOJj9Ye9e8q9Xam/Hig4OEzgaYwS3AHaYQDNBcKGNiaEQ6tKSzRi9pXCW6Aakc7J
 Sm5oXaZdu/vnCO/lvm//Cr1Quj7loNnaea8VJJ1Ke7f8r6GDSa9+BzXEj5WVWd4cBrzO nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf1129u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 15:23:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22BFFKY1054651;
        Fri, 11 Mar 2022 15:23:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 3ekyp4a8tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 15:23:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghmxhWpnV6skTcZuLMhSpKRjSubWPu6wzVzHRxJXHnbiCiktcobM76x2S8mJ84yz078EquRJsHaHjaez3Dft/9klLc7YEVyeYqM4ULnC6eaIIgdq62b8x4lH2+mUARsxiCtxJle8BBVGMjlBK8nOMEWuWTE7oBbu89C8PS+3YShj6wetWRz3PDux0hgk74C7WeMAiXyFCSYKq4T06HUcBpB27xDsoyT8o1LSgOG7knWmAZ9s7WkSS0dCaLkWVwZJQ+PfnP+LwQC+o6bFLLqYSPce9kKwuiOFmJjQqVKppnMQgtWx14QfzFWHQIYoe27k7Ma5gRnGelyuVRjXLgJ3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfaOQyjDHPY/9uF/sK07kFxz4h/OLP9T2BByYY7cr9o=;
 b=MZ54DNHhHidwq3RjQXLL8EuKismweY/n12lQBezmbyPHrJhFLXAWlsXrW3gB+gnF5KMKr40QDKuGbPmp1d+8ShYGUBYvJ+v0+HHkE4u1JDyQvL271KMQ19UnB6EG8jelWU8M7HaM2ksSSYkGzfsO1kjqLGueZcEEUUPcStMVzJzMdDHNkQn/zboDzXBcZtvsusnyE7sJr3nBoz+zmE0a2i4vIGbPSzz+L/mD3BtCUf6CzE2lsgjPXLtkHnKcMjzr7R4W76V2047zihQ4hVEhhhDivRVGqMJxEhZegHGrDb2qMuQ+pn86G6WRaiHEenxu98cM2wn24tCVG8odcR3Piw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfaOQyjDHPY/9uF/sK07kFxz4h/OLP9T2BByYY7cr9o=;
 b=bcVcBkHQ/4hjvW+A0H4m0mBtom1hZ+UqapjuJVM8ejNm8aPojct8raTWXmyfdq2O9Opr2djNdisEz7pjHXDqpXvQXQ2ymo7S2zccNZADo9PEQc5d5PydrBqFcW6pDmxeWnrnakSDkmtX9EjDeLmMZbGe4clsZ8s0OVtsJYzFnsc=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by MWHPR1001MB2109.namprd10.prod.outlook.com (2603:10b6:301:2b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Fri, 11 Mar
 2022 15:23:32 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::1422:288c:c410:93bb]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::1422:288c:c410:93bb%3]) with mapi id 15.20.5061.025; Fri, 11 Mar 2022
 15:23:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove reference to the removed config NFSD_V3
Thread-Topic: [PATCH] remove reference to the removed config NFSD_V3
Thread-Index: AQHYNVv3/sqQFsths0SJM9c/P9d3yw==
Date:   Fri, 11 Mar 2022 15:23:32 +0000
Message-ID: <9A70DCDF-2F9D-4020-B936-380D919421D4@oracle.com>
References: <20220311143941.9628-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220311143941.9628-1-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 158a7e0b-83c8-47a8-fcc3-08da03731a57
x-ms-traffictypediagnostic: MWHPR1001MB2109:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB2109605CC106A7FA07AA61C0930C9@MWHPR1001MB2109.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mMKREvGnJngNEQVQWajCfW7ryfYsHnW08bqeN1UdUJ8HGTXfHr6WnCvvn/kXUsWpraQgrynbKKoaLPG0Mb58LkxFGSUKWqaGGZdmg0kNRQXD+zxOkIV1BvnXO1sAaPFL6W1HMtvwawWWlAFBP3k/wIF3OWcQnE2uD0/ZbIVz8HILSh8yBEPbxNxBKbGRCQ2EHd4F1jYgakn/5UrNeIiD5jGMyC1pq5LTfQj02OZsZxVwciyvi7yaRExwSzXh4dNM7E4WXRHoMgwGr+m6m434NHiLqpGUShAlDzF2RWfPXtPWSkmX11JcjrHaf3sVqUQhB0cyliJ+T2rdaA/v3w7wUpXkPEOY610TMt+ZNMIYZ2LZECchcC1vnCj2w0IQBtO8lZ3Xr7sfdZmFtvbjkF4BCxQND6N9xWs1CKPqrxp2vm0CWaAJyHli2Aj3jwmS1QR5byXyrevhCGxtdavskkYG2B50xxxkUursWSocNovwM9EVZfNuKV9Ie5zJeHSdXLWc/bwLphvE7kQqneo1zE363scxE2YHMhinRG977HrIShsCvCoi8a3Hp3dh84UVQPPoDPOvqLbVf6/hHeIj3MSlc3GsG6GgTXIWZI3UTrVH6h3HM3px/sgau6/hu+QKJ0OuIUKgL1rjTLzCN9CgtZhz9xXZMYazZVTI6NTVqr5RFc/DejsmniUz01v6J/nCMdGfRh1p1fbhoAwi0iDQxtXkiZrWoG/6AIkAz2Yfmikrzjo61iwA1OpGcDC+cDyrryCP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(38070700005)(71200400001)(2616005)(26005)(54906003)(122000001)(6486002)(186003)(38100700002)(36756003)(4326008)(86362001)(2906002)(53546011)(6916009)(6506007)(316002)(6512007)(64756008)(91956017)(76116006)(66446008)(66476007)(66556008)(66946007)(5660300002)(33656002)(83380400001)(8676002)(8936002)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A9inMHM7udx3OfgETNS8KN2XSskcjjht1+w759fgVWXMc+C7Y7PCZ+3sgnOG?=
 =?us-ascii?Q?SC1YxsX0TmSA74bOzjMNWND4aErKyOw4Odx4QpqaHx4APXiEHBH/b18Di0wz?=
 =?us-ascii?Q?wsRkkMkbnTWWhl6O8HqFDO7sGdvw2V1EdHmu49OOm5XYcSbDjeun3g+YLYio?=
 =?us-ascii?Q?dg+hWP2whqYsTgSWIw1GQk+Gt+WBPBKd8E2Z84E6vAgNiXHEAxhf8M3TnSf1?=
 =?us-ascii?Q?TuFXpzQsmIS79BDqNkwOG71ftDQMNc+h0aMwqChfLoMZ/adyoZB9ypfbNk/G?=
 =?us-ascii?Q?EkYMKxzVDPZYQ3Fz1A/kAwxltwPRB99LHIhFkeqePaLRvhE+dKzJFUTf6x+q?=
 =?us-ascii?Q?iCzPaLBow2zZQatjO0aeshGHLYcSd6kPLtxppl20UPWpSB9nXqjbtrLyjtmT?=
 =?us-ascii?Q?6sKmMkX9N6hHAEypCUiTUGl2v9Q+y7Y+15h1sVEXjyQdg9p4EM1Am8mUeh2u?=
 =?us-ascii?Q?Env0YEkPOYu0sDwfxz8hisqdZvVwlFrFH5gdtaeW8CWOi88jOyG4sD/bmZNc?=
 =?us-ascii?Q?R2oUMNNJrDqJypvXwBO7Q0TohrsC41va08C64RZD4vm/bekfifFKbgVgnlR1?=
 =?us-ascii?Q?MeRLo0tIV3T1c+a+uW0tAl1AHVItnrG2ORiZoDuom81EAPP5XWHxCOU5+QZu?=
 =?us-ascii?Q?KS94hSO1sFhMnvgeI8KHT8CyiDhJjuVx450GJYxJyafpQDIvk+D678IRNcu8?=
 =?us-ascii?Q?km6kD//Ej5viGazKwcUhJJg2156DDcjPnx7ES6S9WFg20OWVZHMmJ/unNFde?=
 =?us-ascii?Q?+4sKEV9vyq2RffslyniHU0rERhYT2hMi0/2n7p/rK6qMWnEeVzHfGR0yN/Wt?=
 =?us-ascii?Q?RU3FMNbcUBpjNkZtqyY6ZA9gFEBDurtVkRu808FLQhdjlD+9VD7TwT65vJr1?=
 =?us-ascii?Q?j2IYUEr6wN5fOYr/8/idh/HFa19/G7YnTeJ38ipKVWl2YJdd6D4uC2sFiTLE?=
 =?us-ascii?Q?01YYxQviq8kemlMrdWKzohbmoC57NIKqZ2Hj08Xum/NyCnVBm5Qg+VXsLzO4?=
 =?us-ascii?Q?R4sqokjxewpmARaaIS7rBcNe6i9jTWolJcBVRDRvwdQoC9lrEZv/iGoI82TH?=
 =?us-ascii?Q?q8GoYaDqBGTqWwf1NpDfrQTwOSKRJ6egmpjowzsRcXViWcg7OBzAt1eqF6Y6?=
 =?us-ascii?Q?dCSIOnNBG+tAlnTKt6i1LI7Kj1xqnbIe6ML1NuWMK7155HAeXwhEjPPkstOv?=
 =?us-ascii?Q?OUwpK42xGoWVpVpldkq6D874Pot6StXPwMnWPCdi0X4Wdpg8eT27Ov0WJHAr?=
 =?us-ascii?Q?S2ckxieJ2BbjFeZ6fA1ZtlxcKvDmJOMU33Jr3jhCDxtBzvBUjLOATawFW/3M?=
 =?us-ascii?Q?8QYZkfDPR23pCPENbuy9Vf7rjcM6E1hfDldByiFSaFkoIPkV42QOsgaFX4XT?=
 =?us-ascii?Q?Me2PAcevbRhIQYqMWz5bFowEZwkbJV270eM3W7Lc6WXTSlJXDuIs1Sh3rO72?=
 =?us-ascii?Q?ZYNIq6cGeQxcarXym0sKKSOcAJFof+To9I/cZEFzNYQOtZHJ+I7xoA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFC1D09BAD49AB4F930EC45A47D60804@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158a7e0b-83c8-47a8-fcc3-08da03731a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 15:23:32.3661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQ5ooBG4AzVsc5fM1I3U25LSvT1yg08VeDiTeDaXDknnssp/qJFjudk5fo981BD/PJ7HDETxaE5DlQYDrUDDow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2109
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203110076
X-Proofpoint-ORIG-GUID: pmPaTVGf_TZGrKAr_k3rbbgS_ocu-zte
X-Proofpoint-GUID: pmPaTVGf_TZGrKAr_k3rbbgS_ocu-zte
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 11, 2022, at 9:39 AM, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrot=
e:
>=20
> Commit 6a687e69a54e ("NFSD: Remove CONFIG_NFSD_V3") removes the config
> NFSD_V3, but misses one reference in fs/Kconfig.
>=20
> Remove this remaining reference to the removed config symbol.
>=20
> This issue was discovered with ./scripts/checkkconfigsymbols.py.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Chuck, please pick this quick fix to your commit in linux-next.
>=20
> fs/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 7f2455e8e18a..ec2cf8ccd170 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -344,7 +344,7 @@ config LOCKD
>=20
> config LOCKD_V4
> 	bool
> -	depends on NFSD_V3 || NFS_V3
> +	depends on NFS_V3

Actually, I think:

	depends on NFSD || NFS_V3

is more correct. LOCKD_V4 now needs to be enabled whenever
the server is enabled, since NFSv3 support in the server is
now always enabled.


> 	depends on FILE_LOCKING
> 	default y
>=20
> --=20
> 2.17.1
>=20

--
Chuck Lever



