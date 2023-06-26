Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836C673E303
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 17:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjFZPQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 11:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjFZPQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:16:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CB9D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 08:16:22 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QBZUrA018112;
        Mon, 26 Jun 2023 15:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tyq1Ams/OmN96h+I4w3GfD0R1UGKYwMdijLM1vdYibQ=;
 b=nrY0S48QjJlAnEfHzCAFSzFc3mE2WRBB3gyrZkCFEj4TzNv2rX3O5oTcEYG0HFn0k3V7
 4PiNFUJN0SDwocKTXu1mY0Pl16Cg0Y/4/NvBfqxhFElEHiKBztdATnUFsh3GmtADYI9Q
 0EMRl0ee0UBvde6GzteaZYtguA4IXGOHUyrqtCc/6dBuqqSxPlkv54JD1NQj8uJ74JM+
 t466HmGGXMZM96CMuiIgLs0oRl1AnFc1g03COyoohvJBFKJ/7MnY8rGfeQq2CP1VPLmN
 SyJbOx41H0YtJJ5iFcWMJW0WVjVcJE4A6s/VYdg/SDYqRNnZSnQiD2B1dD1U3bh+Yq4F SA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhcjym2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 15:16:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35QEkKT4005174;
        Mon, 26 Jun 2023 15:16:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx97xud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 15:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMk/tz8DlmCtjv61BKRC+MqaqkY3YzRMSW/mSDnfsM3N9etcV/u0F+5fg+p0IazCGkGfg6tU1DpBJwRtjoj0EYFg2FVPHhehf6m3lQDX/Jrw9pK1fyxfl1l1nNcFs6YgXXjHN/L5318jqLwYmo1q63ZUfCoFas9Lox39BMHrOMzeHuUfy1dnNYT0J9/x2HLX5woKT7uJdBr1MjKm19Zz5snA2D/qW9zzQAwF6Wzx97NQqI3IoxahcjcPfsY4QtIHRT+fvghUWWqp4qLMa66LnMmL/l3mo/b4Y3wheBqvnJhCYdipmve3I+j1iToOs19F0HZqEy1AyZc3cwflg8Ucyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyq1Ams/OmN96h+I4w3GfD0R1UGKYwMdijLM1vdYibQ=;
 b=EYoq17NU+CwmVVMAldP54TU5QLrmaaifLfqAvcNXb00Ih2RSaRSKvIs+aHm4dtHAPlGO/aWZvhWg+uzU6yWwZntLcpf5NHY2VT2g3W/T+fW9q7x4Zjso7nl2+GaOJ5HTAzYQJQ8jhlsGfrPHGvdkIqMYWF7cmfIqaGEw3+56Lhwqe//x6myvHaLKSr+zwi0zsyDb+0ebpBJ6FHLj4dLIzrJWwYqILdV/7szjN0fwxyap0BWrkksu0RlPmdTYapMG+0trrFlZdwbjHN99b0wxIphB5SfBhZ3+NqPWWl9juAzQtzjlLX3zU5zPlbljfyCixP1b0pGf6uY0E8OvcdPqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyq1Ams/OmN96h+I4w3GfD0R1UGKYwMdijLM1vdYibQ=;
 b=GyrhHM3h+0vV0ESZnhr27nzQ1rXtj18CjGKvZ4tlgJK7EW3HAVrIiL3xf1JHmnE2R7mGrug6aqSA4ZNAUgrlAK5WkEp31nR2CQYGpupZhsVdtUmXpm/VqFji6rMkLQ8KWzxIfCg7Leb+cc1FuG8QQJB4/MZPcpdRiXP7+B+mAf4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 15:16:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 15:16:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
CC:     Chuck Lever <cel@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] shmem: stable directory offsets
Thread-Topic: [PATCH v3 3/3] shmem: stable directory offsets
Thread-Index: AQHZmHhhMyqRShvAYkmrxxMGTdD97K+dMIKAgAAgwYA=
Date:   Mon, 26 Jun 2023 15:16:06 +0000
Message-ID: <C182B654-6B83-4638-A471-0FF623A08C0D@oracle.com>
References: <168605676256.32244.6158641147817585524.stgit@manet.1015granger.net>
 <168605707262.32244.4794425063054676856.stgit@manet.1015granger.net>
 <f6191d0e-ede3-620b-ae96-311b001e1ece@fastmail.fm>
In-Reply-To: <f6191d0e-ede3-620b-ae96-311b001e1ece@fastmail.fm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB4991:EE_
x-ms-office365-filtering-correlation-id: f4a3e2bc-ed5f-4339-775a-08db76584359
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8blKrhmS/fyWWtOPSQ3woEFdN5kv/Y6dBZImfkdWYVFwhUq+BBzcHTYE1Pcj4TLLhTMax31xYCGgB/W9w3DOCeMMlC5nFpL3P7L/AHjPfbhrR+aBPIK0+S3NyEEJ5zo0m5VDOC7N58/xS2b6uS/E9AfpN7nawpxCUlOcXpoeb1md2xUKDzkUn44U8ypRMTfWiK+QjkJIoNbZ6fiFWYyGKf++d6FVLUtGLZNpZzh1uTFM7V6wC3x/nTSdQ8H/QkqZn2SwjkAANbZaaMmtod4AEPvue8jaEhsS8azTd+KK/9QZ5iuy+9t29BvjdkhgudgQZFRYxu43c6ZusdjaGSJmvadv8Y3/GwjnQrtn4TkK+iQNYXLnxDmtgKYiKXQCCgUskIsIYugLORRU19wH1uchyOok7GA3ZPwllUUajoXbvgSo29e8rSNZi/w1MjHDzi2VGNYkC/6zVkyRNsbvMbPRp/zlw8ltDm5fU+/GUev2/AFDBHb6J8doHU1zpEtvvXNLspRv6W9EvUhgD9Iyt6NGmQZEs2EM1+NaxHQzPzhYPxc5uQHkJKldQ7Gluwi6xIRTr2XC3j7oIMbpSSaCSIgVRKDlJABmGJI7RFjqj7aiC4bgpYHLuuCGsBUVRIiEUqk+4nJZIX7/786PpC0A2N9QnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(2906002)(6486002)(71200400001)(122000001)(38100700002)(2616005)(83380400001)(6512007)(6506007)(186003)(53546011)(41300700001)(86362001)(54906003)(478600001)(38070700005)(66446008)(76116006)(4326008)(66476007)(91956017)(6916009)(36756003)(66946007)(66556008)(64756008)(316002)(33656002)(26005)(5660300002)(8936002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GfkUZOxlbluSzUIoQghKWXXAWmifUsltXxbVyeJJgWZQSpOgj7g0DV4Gf+ic?=
 =?us-ascii?Q?kovHxQUXdGP9fkhgaavm0h1t6itvR0sZG6EGIl7hVdFV/PvDzcDjSXeQRin2?=
 =?us-ascii?Q?WkBpp88KvpJTw0KCp0YQ5spypwB7RNOoZRUMKCmUOUn+siCLlgENrzr+FCAd?=
 =?us-ascii?Q?tZtGTY8MrTVO5ByDpyJb4yDdkq6DQ5eRIwFsbwJmq3/Pyd6l1+2vMvVOfZqG?=
 =?us-ascii?Q?K4I7Y+5HhyJabPw6zMiMWVHV8n3IrXE64c2EydFtHHCDGLd5vuA92uEMZWS9?=
 =?us-ascii?Q?g+Hr1+EG1KQ1773q5tKALZEdfZmV8giKIOKIZB3DzpXK+Yoz4iIabELYi1gE?=
 =?us-ascii?Q?9FbX3URVB8ST8326ad3JHye4+1qxmjyk3PfUS4iKwKQW/3/asZiYfqmXsRl3?=
 =?us-ascii?Q?PWK47USPg58Jj4/0J20ZUVg2ZgYkVdc9C/8vJ8TyMEDaX6/1VJSyDdRmPWH3?=
 =?us-ascii?Q?3C6nrKBRxEa2AfgrIQ8WQTc8mynoVnedcRz+7RIiXn78T8dX1jGBodD0p8id?=
 =?us-ascii?Q?vUGX+MvUjeqcJjBN1QTY1vl6mlRk7lHfWWgVyExToWNE0IFDSQ3mvCXmZde8?=
 =?us-ascii?Q?EixHQ8jPqEzn1FkqR+bjKuho0hnssOKE9EqKOU/0m/zAY6AR0K94DPDF3Jj9?=
 =?us-ascii?Q?l/eCjJyPaHFUHiVkHXSHIjLIUYS7LVfSs0yJlls7WWLqqM9hd135Us94QZIr?=
 =?us-ascii?Q?EbT5RMxnaua0c8AavPO0IPPS6/M7aqlGYkKtTka9M9XER4EEzaHEdhxinG5K?=
 =?us-ascii?Q?ViiejxQFHTKd5adLK3GxT8WaLMMQc92X8inLp7m5H86DdbNqQqFnNjJHa3V2?=
 =?us-ascii?Q?kD5aNApmlmTeRP4ENdwtA/iYcOuJPXbDz/ONcwdD89QW7z3mckkjWXeRtII1?=
 =?us-ascii?Q?ojFCNPl56AmeLQ2FM5DgsuD04WCDuTOQNCfNwwaDkRuaNqrVk7zIkbEl7rOR?=
 =?us-ascii?Q?V6rqvy+0IGJ89q38Y5OuqWFlN7GCuSXNRiM40I0Hqn8AfKJG+djId4fDJ+yN?=
 =?us-ascii?Q?EVsF7EtExvjhpHuuUJ/SeboX47iM0ciHSAzD5Z9tH/pWFaTZAChy2CjGwsBv?=
 =?us-ascii?Q?Di0M3b2MSwFr3Qla9DbnSw5TSJ7XBH/Et2RWEmwfTLoiwRzJtTNy8xj+5UGM?=
 =?us-ascii?Q?1H2jl00HVvGwnTKHved8MxwnZNDcSfZkQMUY0okzGjMftgINfKZOmpHwa9Gl?=
 =?us-ascii?Q?tLhJtQLW9HElNz5hjAThXU2morrYD0lwOL2HncoY5tL4UHSSDhQ/O+uX9IeO?=
 =?us-ascii?Q?TAZb5Vsh7ezdFZs6XkQDE12c7ftlD/vaTBBAYjqgD0lkfX9sHzTOrthSgv9y?=
 =?us-ascii?Q?hn4JlhATysMq5llxsMTSbWy/Y1dMEJYSwArnbSNbEydWQMLO1MI7SH8xTece?=
 =?us-ascii?Q?lghJo/0yXJRz1sQL/wXkyWIKILhnAfCz3Rk9/9O7oH1ZcU+C826TqIFhNymR?=
 =?us-ascii?Q?XdIeJsmRIRaz+3dBhnsb27yChagyUaPuD2w8iXNXvHLI1axJzBXQDkQe8OUN?=
 =?us-ascii?Q?3wgEQ3n2NbFNRWQnQBBE3l8iIqF7IZuQWeny1aZTC4D4Bb/y/GKCyKXypsHa?=
 =?us-ascii?Q?scGwZQrXRt64L59hqjB2l4B9roRTXUe1DtlErIXi8zFERSXQfqq2MQUrTuJ7?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E133D169694A74B9E7B13097D509D66@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zffutM1wxIsmDI0piLp33F7WbYBzbiiTcwlxQom8IIuxC6/1xB/RC/1BnYfN?=
 =?us-ascii?Q?HlwhKO4zgmfWtQew44bzfmfqAiimvyvgzrhrAV6GxYO60jazH43S+47yJ/Hg?=
 =?us-ascii?Q?uIGEdqvFpWJr9X29T0Z0VrSkrbk+HW7xgNm/uCqOcGDwi9H9+9jsTE6wyUMy?=
 =?us-ascii?Q?WyinT7yL0PghgUW34PaPysTnkkn9OhT5I9ti1HeCjivt8ZSo5ejfn+0skznD?=
 =?us-ascii?Q?Sq0t7IZ0wizfM+yLlmHZyZfWTOZd3nW2MxgUHitEELIfU/p2m5hWuDKShWgQ?=
 =?us-ascii?Q?D1qHndh8VQjDgiEXJNVPsl4w09Ji1lhM5fjZouHHI9Rg1lduu/pHkF2DZS4a?=
 =?us-ascii?Q?lTcSFtbg8b9NR0A9tGR5UQCT3+qjn9QqEsrbuf806cPlOF8GrxJ64DgZ0Q0S?=
 =?us-ascii?Q?+7i1NhdJe8Cg7gRi//D5qira5tc7tEaa7B1vykRTP4UxLr0C7Q0lC8xyETd2?=
 =?us-ascii?Q?gwHOTwXkjLew4jpiZL/Vky3CCQR4fvozYJ2FOZpitpTa9gIs481GCnEt0m9J?=
 =?us-ascii?Q?4IDEqsaDREWxCK/TIGLfet2DlnByklCJPPPeMoTFo6wfHGTlzVtmX0Fn3wX/?=
 =?us-ascii?Q?Vsgljl3FQuR/DCNVMHTAdorMGHW5Kd5y10oQCoqfX0rhRC4uSRdp8AYajaML?=
 =?us-ascii?Q?52xgGyCgxVuH9PhikOcxfduOHBmEAhF5N5VJBSJvWkbxhG+5eKSF2xX4PJm8?=
 =?us-ascii?Q?bUHGzxSTdpJP9NcY1uQ1FBnbmJ88h9FmnKIESydQ27+Xa0fd6+PQuQTsWgC1?=
 =?us-ascii?Q?Tx189Vs8PXO0wZCwunk0G7aTxbsH1WD7rZ9WvEy7IxfoxD4sOQSFiL8Fd8/S?=
 =?us-ascii?Q?0t7IdYsOd1H47zeG1Zj2Nh6/ZE/GRvxzsHTaBJdJd5P237pNB3+/DY+B5CiD?=
 =?us-ascii?Q?U/6tMaNb8Ozqbb1Ok+G7QPQMcOYx+eHyQT1nYEb+uToNH8GIQ4vLG8gDzo2g?=
 =?us-ascii?Q?SaYEiBiJ2RuD6BW+iBIWfGf3MOelbFcHPlE5S9KJaVQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a3e2bc-ed5f-4339-775a-08db76584359
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 15:16:06.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DryCrYTItrbWywfIkgtzgsOk0+h+L5L1DLmt0eye67ip002wqrYbRj3pOrFoCsVNhPTXJQAeE90o3XTF9CXjdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_12,2023-06-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260138
X-Proofpoint-GUID: Fe3Va5YVmypwtXLVDHd7VBVaZNTPoh0c
X-Proofpoint-ORIG-GUID: Fe3Va5YVmypwtXLVDHd7VBVaZNTPoh0c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 26, 2023, at 9:18 AM, Bernd Schubert <bernd.schubert@fastmail.fm> =
wrote:
>=20
>=20
>=20
> On 6/6/23 15:11, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> The current cursor-based directory offset mechanism doesn't work
>> when a tmpfs filesystem is exported via NFS. This is because NFS
>> clients do not open directories. Each server-side READDIR operation
>> has to open the directory, read it, then close it. The cursor state
>> for that directory, being associated strictly with the opened
>> struct file, is thus discarded after each NFS READDIR operation.
>> Directory offsets are cached not only by NFS clients, but also by
>> user space libraries on those clients. Essentially there is no way
>> to invalidate those caches when directory offsets have changed on
>> an NFS server after the offset-to-dentry mapping changes. Thus the
>> whole application stack depends on unchanging directory offsets.
>> The solution we've come up with is to make the directory offset for
>> each file in a tmpfs filesystem stable for the life of the directory
>> entry it represents.
>> shmem_readdir() and shmem_dir_llseek() now use an xarray to map each
>> directory offset (an loff_t integer) to the memory address of a
>> struct dentry.
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  mm/shmem.c |   39 +++++++++++++++++++++++++++++++++++----
>>  1 file changed, 35 insertions(+), 4 deletions(-)
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 721f9fd064aa..fd9571056181 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2410,7 +2410,8 @@ static struct inode *shmem_get_inode(struct mnt_id=
map *idmap, struct super_block
>>   /* Some things misbehave if size =3D=3D 0 on a directory */
>>   inode->i_size =3D 2 * BOGO_DIRENT_SIZE;
>>   inode->i_op =3D &shmem_dir_inode_operations;
>> - inode->i_fop =3D &simple_dir_operations;
>> + inode->i_fop =3D &stable_dir_operations;
>> + stable_offset_init(inode);
>>   break;
>>   case S_IFLNK:
>>   /*
>> @@ -2950,6 +2951,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode=
 *dir,
>>   if (error && error !=3D -EOPNOTSUPP)
>>   goto out_iput;
>>  + error =3D stable_offset_add(dir, dentry);
>> + if (error)
>> + goto out_iput;
>> +
>>   error =3D 0;
>=20
> This line can be removed?
>=20
>>   dir->i_size +=3D BOGO_DIRENT_SIZE;
>>   dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
>> @@ -3027,6 +3032,10 @@ static int shmem_link(struct dentry *old_dentry, =
struct inode *dir, struct dentr
>>   goto out;
>>   }
>>  + ret =3D stable_offset_add(dir, dentry);
>> + if (ret)
>> + goto out;
>> +
>=20
> I think this should call shmem_free_inode() before goto out - reverse wha=
t shmem_reserve_inode() has done.
>=20
>>   dir->i_size +=3D BOGO_DIRENT_SIZE;
>>   inode->i_ctime =3D dir->i_ctime =3D dir->i_mtime =3D current_time(inod=
e);
>>   inode_inc_iversion(dir);
>> @@ -3045,6 +3054,8 @@ static int shmem_unlink(struct inode *dir, struct =
dentry *dentry)
>>   if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
>>   shmem_free_inode(inode->i_sb);
>>  + stable_offset_remove(dir, dentry);
>> +
>>   dir->i_size -=3D BOGO_DIRENT_SIZE;
>>   inode->i_ctime =3D dir->i_ctime =3D dir->i_mtime =3D current_time(inod=
e);
>>   inode_inc_iversion(dir);
>> @@ -3103,24 +3114,37 @@ static int shmem_rename2(struct mnt_idmap *idmap=
,
>>  {
>>   struct inode *inode =3D d_inode(old_dentry);
>>   int they_are_dirs =3D S_ISDIR(inode->i_mode);
>> + int error;
>>     if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
>>   return -EINVAL;
>>  - if (flags & RENAME_EXCHANGE)
>> + if (flags & RENAME_EXCHANGE) {
>> + stable_offset_remove(old_dir, old_dentry);
>> + stable_offset_remove(new_dir, new_dentry);
>> + error =3D stable_offset_add(new_dir, old_dentry);
>> + if (error)
>> + return error;
>> + error =3D stable_offset_add(old_dir, new_dentry);
>> + if (error)
>> + return error;
>>   return simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry=
);
>> + }
>=20
> Hmm, error handling issues? Everything needs to be reversed when any of t=
he operations fails?
>=20
>>     if (!simple_empty(new_dentry))
>>   return -ENOTEMPTY;
>>     if (flags & RENAME_WHITEOUT) {
>> - int error;
>> -
>>   error =3D shmem_whiteout(idmap, old_dir, old_dentry);
>>   if (error)
>>   return error;
>>   }
>>  + stable_offset_remove(old_dir, old_dentry);
>> + error =3D stable_offset_add(new_dir, old_dentry);
>> + if (error)
>> + return error;
>> +
>>   if (d_really_is_positive(new_dentry)) {
>>   (void) shmem_unlink(new_dir, new_dentry);
>>   if (they_are_dirs) {
>> @@ -3185,6 +3209,11 @@ static int shmem_symlink(struct mnt_idmap *idmap,=
 struct inode *dir,
>>   folio_unlock(folio);
>>   folio_put(folio);
>>   }
>> +
>> + error =3D stable_offset_add(dir, dentry);
>> + if (error)
>> + goto out_iput;
>> +
>=20
> Error handling, there is a kmemdup() above which needs to be freed? I'm n=
ot sure about folio, automatically released with the inode?
>=20
>>   dir->i_size +=3D BOGO_DIRENT_SIZE;
>>   dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
>>   inode_inc_iversion(dir);
>> @@ -3920,6 +3949,8 @@ static void shmem_destroy_inode(struct inode *inod=
e)
>>  {
>>   if (S_ISREG(inode->i_mode))
>>   mpol_free_shared_policy(&SHMEM_I(inode)->policy);
>> + if (S_ISDIR(inode->i_mode))
>> + stable_offset_destroy(inode);
>>  }
>>    static void shmem_init_inode(void *foo)
>=20
> Thanks,
> Bernd

Thanks for the review. I think I've addressed the issues you've pointed out=
.
Watch for v4 of this series.


--
Chuck Lever


