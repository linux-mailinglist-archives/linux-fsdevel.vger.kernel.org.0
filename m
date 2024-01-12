Return-Path: <linux-fsdevel+bounces-7844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7073082B9FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 04:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C24B8B23577
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 03:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4C1B282;
	Fri, 12 Jan 2024 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="LjJ/XRy1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3325F1B27B
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 03:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gA0RjDAePpzMuvjKvj3uMjBMCgQ101zdly21FfLdApHao5+eUGoDnf/eqX3EbP0WqZzbbhFV6anE/AexDuMmQacLYlasg11LGOupa9kGJzi2pE+RefB+9gX8ieW6sMkngxO3L/MUr5n3XnOmqgROgzaiXVsPkW3PkrJssnLbvlTE02wVy2nRHut376OsiJER8TjdAiDPQuHimxr5YV51GSXI7JM2rAebKdIfqxPVt4Si7974S7sZpk6aObWis82TfD3vbek/yTygO5HsgP9zl/DOclKIeWWjOIfTGdI/C5+lzJhRlTGKYHn708Lx01Pdup1FOf0asWDRwufELJj+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rBoRp+qlFImkfVNxSu/4Z/w+Mxr4BtoLoDCANBYpoM=;
 b=JaXve3Rf9myoKwnoYctVW/QF/N3VdrY1EZQYBArBYvPMgtUhrv+Jd1/WOqQPDRZdRtJKem0160WrjD48I0akPiIeAF9nKNWQHLEGPQHZyWPiCt8bZPNId9H+pybHLqyX0YIwLSk58vZE9SGZMYWSwzGycK4o7IM++SVY9a3ab9x/1H3jzy+Lpfg88kkX5ORFtHhjBoTctHksIR0ccgpgIxzPezqp8CFQg5ueyc7eJLDWIZ+Gy79ny1+MteULdh+bU7PPf9Gi4mM5m7ZmHD412m9bx87w3YozuSyrtHwuyrS0j/sI9E8O6UpQFpBi2+LKZska8P130kuMe266/HfsvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rBoRp+qlFImkfVNxSu/4Z/w+Mxr4BtoLoDCANBYpoM=;
 b=LjJ/XRy1ew6ibl7BCj+Cg7LNTx+x/mIFk0hw17hAoRMIt6yBrM842o4KKSmNvX2yPxVOfPa1Y/ziBx4KDmDbB2OFp8nXPNHJW/i85cNCVyW6oH8HMPdWOUzs+BQWK1oQ5/CnHtFsZOJ56l77D60DxPLvwYE1scQg/6FDD7EZtdAbkMpOelOTHJu0PcDB2wfvDnICpisSi32h63I1DALocFbMgk4OSKwnVR+nMGqEB3zBOGd4ql8fRboEtk3+2n6aV3EixdYJlL5u8dFn5qLcRcyl4R3LZl+9ILrD3KKwEXAR2XpZJMnEpowlvwAr6wY/l25dvf+1EBeOpGNvWcUV/A==
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com (2603:1096:4:1ec::12)
 by SG2PR06MB4987.apcprd06.prod.outlook.com (2603:1096:4:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 03:34:41 +0000
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::ed1b:8435:e0a1:e119]) by SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::ed1b:8435:e0a1:e119%4]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 03:34:41 +0000
From: Lege Wang <lege.wang@jaguarmicro.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "vgoyal@redhat.com" <vgoyal@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "miklos@szeredi.hu" <miklos@szeredi.hu>, shawn.shao
	<shawn.shao@jaguarmicro.com>
Subject: Reply: [RFC] fuse: use page cache pages for writeback io when
 virtio_fs is in use
Thread-Topic: Reply: [RFC] fuse: use page cache pages for writeback io when
 virtio_fs is in use
Thread-Index: AdpFCEY/UQ2P3yCJQ2WZJGutXBhwiQ==
Date: Fri, 12 Jan 2024 03:34:41 +0000
Message-ID:
 <SI2PR06MB5385503F984A59B9E8382D37FF6F2@SI2PR06MB5385.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5385:EE_|SG2PR06MB4987:EE_
x-ms-office365-filtering-correlation-id: 7973af2b-9ee5-4b91-5b49-08dc131f6988
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xK6f6Sm6mO3ulYuv/SQexO2AdJ+ctnecu8zpoHWjV8edr19NsdlaiMlTjAMbGNIamO3yj38sWM0tGd/SgEYS3j8ewO5ChSl3Ey3TzQ6StXSA659merSeoEczRYBDVQ20gKF2liB1uwCN8u5WQXVCgeShAWik/+MrIUTid+6QQ1liffEU9fNO9rvjbLZMwgwO1JPkdtIs5DDlw7I4F34XFrQ3NkUn+X7CT/jNcc9oGvFfyokSDZY1BsIWe9bFWsnG9ClMSEIfCj1ZlqO/AH1Hv1Ah0jXn7kV3sQ9GFnw7XCRlSekxTsjflxmWw8qEnTpTKwZGPFI9tUtTd4dvNrllw7/s91NmpSxvBpo4jMLiwpLQgR/6rMzLjwiu2HE4Tmiwi96GkGZjEjqugpxkCu7emeUqstEA1L6n/gJmBmP7bXapt7zjhfQZZkiqOG7At19795fjMq7F73vXaz350ZSHYyQSjoWRtD4F6lnKs+I3KzjPgFM3GAOVEUSUkcBGQABxIicAyMxY23yl5xyBcd6zxy41cQuG9V9TH043/PjZCO2yPTZ0CrKVq6cmbth6P6gTdDBFI6pyN65W9HCxoXDthzRHV4uxIJ6RHEaUNc2gz+c8nOFt/n9AAkpYe260Zlzd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5385.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39840400004)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6916009)(66556008)(316002)(64756008)(66476007)(76116006)(54906003)(66946007)(66446008)(4270600006)(71200400001)(38070700009)(107886003)(9686003)(7696005)(26005)(33656002)(122000001)(52536014)(44832011)(8936002)(8676002)(558084003)(4326008)(5660300002)(38100700002)(86362001)(6506007)(19618925003)(41300700001)(478600001)(55016003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kghUu9B5Jj88UsEQRL/lQ2zoTpBxKtLybPBCOal/n7PJLrXUdW3fT98+4tLY?=
 =?us-ascii?Q?cenRecn/jmN/+uyztF4c3EsOY4UOHW1h9j0RC27jOYjbeYXSPdIipXqXHIIt?=
 =?us-ascii?Q?ykBRgAq6mrizpzVd680imqwRTqmz3kvYXt4/9fwI9Bv/nbEjz57nVE4WOND1?=
 =?us-ascii?Q?NVySWfT2JR7nxEKNogtvFPYz3GZ2wLO8OyEUH00mjJ8nHsj67S+5a4Rw+on/?=
 =?us-ascii?Q?2rfu06nVtd+VDdwCcb6OOaYh58ObCctTcyXJlfIg9qngpbQ73dEUeKfpudZ4?=
 =?us-ascii?Q?A8so+22nNOzydN91/ussAPYXZxwG0SJx+SmchlaVNZ3FEre1mcEdKOulA0Qs?=
 =?us-ascii?Q?jdv8y8rzSFhKmZLJGF9qKshaoP5UoLOiVtiISp5QwBGjoBkX9J20gBJ/686X?=
 =?us-ascii?Q?C8vmVjjp8ZUKqKDmgeYK/r7vJaodgWoZj9r+xAon7cs40uACPERKxRi/LCz4?=
 =?us-ascii?Q?tUCL074ZsDiIObqPe2U8Vb3L8HrOZqciVNO9knGMrPXQqJaXXykAiafcivWq?=
 =?us-ascii?Q?9yBL2NKmE4s8z5AqScOE7kidJg8kK4Fu0LBEVxWbbsqKpz56H7B9Bdm8Idnw?=
 =?us-ascii?Q?HQWo0FUMB1mUe/kczxfgFxAdVB9SDeiD4s8/wfzOMlgKlelBh8QpbqySu320?=
 =?us-ascii?Q?QL1Wj8hvwRU8ZlaMTZrh0PQ8MtEZ9bWvtpL04ULuzn5pQlC2y/e7erE5KRsw?=
 =?us-ascii?Q?wjjgLIoeJS2mTiVcUnus8hdjmq2EYVKlT6K4NP5AYsTnZVdlatdWrmDfNezS?=
 =?us-ascii?Q?Ke9qWf23uCIQhQDqDCfJAJFcuxv/cOZ32tk1EA3llIrBdwvuv5hV9HQPutp6?=
 =?us-ascii?Q?gUTmI4sPtfw9X8qbhAeV53TPrgxPJhI3vbMaYdGbs/b/sTFXQasI08h7CKCq?=
 =?us-ascii?Q?o08+JCQYQ/a38fdcNC9nEieacTXyHv811BPuCW+jQbgEfoWofqDfqUHt72E4?=
 =?us-ascii?Q?GTrzP+dQnfxtR63UhB7cF4k5+FOYo6Ul4ALt48OkuRkexEkZKL8yIXBkvrj+?=
 =?us-ascii?Q?mQlX2Tj7U3fxv1eY2IBOywWRZVI3wlJHbS7Tnq3gaDh69l0g+sB46zj3YTBa?=
 =?us-ascii?Q?YQUpfDDuT6d/n5agGnkwLpFHwcrfQjQITpaKb1LJ0wQFiaPmX4djjx654Y9j?=
 =?us-ascii?Q?8r28y9x2a4pQRrGVL1hU+o2ABJxE0x3GmuT0CaVDmNRiH5gfYs1m2W0Avo7F?=
 =?us-ascii?Q?QYW9T1ggDLP9mMgLxVw5OIS+ngEnKznFSYGIKiRoW/zXgg0AK/oYzlcuiLj3?=
 =?us-ascii?Q?OP/ZxpMsp7f9QDVyQRXLMHiZTlRmSdygW9EAxGSymrfW8X1WqKc0JJJ7lvhB?=
 =?us-ascii?Q?7WNkED3+KWJJTBZ0AUSqa5LLBwrB0f54ips68UO9OuCy/rSlc+zT7Zyp5aj4?=
 =?us-ascii?Q?kQfXf7H69uy6MlOpXivrJWsyI7Alah6cr1RPFbVD9cvcOVw6m64dr8LysSsS?=
 =?us-ascii?Q?3qsXtdBIiZmZ6I0cTCM+kcPLmH8thi6cPDyW/yvjul/bavPSSii8JUQ87SHe?=
 =?us-ascii?Q?4kIDU+/mza8cNNpnc/rjnA9x9/AfdVo5l/+2EsXsVLBaxB9F5I6Q5xIG+RuZ?=
 =?us-ascii?Q?MSK2zbTsum9Ci7GBfFB61oL8ZUNHeM6Ej3LJpTTr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5385.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7973af2b-9ee5-4b91-5b49-08dc131f6988
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 03:34:41.4768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6C4+XuSbX0oYQCdKe0Kloetp+4Xk8FQVUCaZ0Rc8f9ebiVfoQWWsSJLjC1Dul1v+ZtlVH3enTUjH8Dzyw4EQEiaXqVViJ198DU4vzdqrqGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB4987

Hi,

Any comments about this RFC patch? Thanks.

Regards,
Lege.wang

