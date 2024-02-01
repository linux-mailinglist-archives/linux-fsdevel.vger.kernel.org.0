Return-Path: <linux-fsdevel+bounces-9809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C9284524E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3B628AF4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3824F158D73;
	Thu,  1 Feb 2024 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XmMZV13Z";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XmMZV13Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829481586F5;
	Thu,  1 Feb 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774486; cv=fail; b=HxqZRuh0sXy5LCq13LBzUuf+cFKt83rB9wlS8FQSKuBRnpgjqMRlzlmrT/YZziPk7X+Nzav8wqvoLinNHaH5mMPvxYvC4opsagg2Xuxf7zC5VVRPaDTgJ7d9SMgS08jl4WQTWKQCkk1LFhuFsVB9ZWQXh+7cl4RJ0MQ1DoUB9HY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774486; c=relaxed/simple;
	bh=wAnDVBP35Dz3mMrGQMWhbA0UBZwZt/iEFlQjE7kOVFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQeGoueD0HqXN6ZcYtbBX2BP1nxVim/clVbDPfdDjw5ISz6dHqR0jFSy6fiHo+NjsbNqLthsIeAX4dZFi0v7NceV8ncIEyiM6IosXUBI2BbL2TZKZ5q9t1h6fsOfP16Fmx/jwhB3bv+TfEm1bV1BuULcqoCGfz1nVc0rF17pAgY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=XmMZV13Z; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=XmMZV13Z; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=UMpEGvV4NtKJZxPeiP2C8PvUYiarkhKqFXLOxDUpGd4G50w0M+GlfZ/1DQp9nhDZOei6Olrkas3iLrSLqom3ROr/cyCisUboE34gGiKiQq4Z2aIFVOKyRFkbCGrdqvmIMvpwvnbckJ02Mpac3AeoEj7cX4YwE6yCuat8SWG2WwravS/iovOJzNH7SPIWWyrjgLwP5f5zkd8RO3oTuQcYOsO0PVNHM/VWS78JTQOgt/hoeGD6L/Ta2HjiOMQA0IFR7UzGzTpl9IBG/d31+BIkz8M28Kldji+cS6aMewJ9pg2SltggLwmDOP6LBZiIByd7PzYd571ippNaLPgQiHAkKg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFFYoBB4PMIq1taHw7IQAEuPC5tfXYRY1wnyqLat63s=;
 b=Let4q3KWo8otMetZmKl5oNI0tBjEIuPUlwdF96B4gxx0+GlNAEL4TG14RHr83q6GWQx4iZpEQkA42I1xczKggx9Roz7OJsLXUcF3mU50ez8ocjpGJMQa5ygRzAvCKfOqbQchvdzlvbljIFELcjdyGRGtkhrquAfFsMrjZHePnlOIJEq55c1f4BbGSpl2a/u1p3iaSnYO3nYnxRWStqQM5uFiIQZpi+MMGzTc7G0alwbEiC2u0IUz2yjVIXsL4SBdPZowzsbXy9ufAEpSfgWjAos+nRrVw30oR/Jehs9R+8cihWao4c50WchcPkst1kW8xZUYND/9nN8B7HqStz/R7A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFFYoBB4PMIq1taHw7IQAEuPC5tfXYRY1wnyqLat63s=;
 b=XmMZV13Z54lPKk27j0Oc6h84JW2nvsiZbnoIsxn/xnd49blRi5dRl8ZHRjb6GP97i1KT6GO2Pd93cwuY42/7OkqwNnZmHIddmB843zvyPtzaVquXg03p/yFFC+DxGByFQZS7V4oeR3Xs0odUgP/W1X8jtelwVgjWOPu1NuUy/tU=
Received: from AM6PR04CA0008.eurprd04.prod.outlook.com (2603:10a6:20b:92::21)
 by DB5PR08MB10215.eurprd08.prod.outlook.com (2603:10a6:10:48b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 08:01:18 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:92:cafe::d7) by AM6PR04CA0008.outlook.office365.com
 (2603:10a6:20b:92::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Thu, 1 Feb 2024 08:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 08:01:17 +0000
Received: ("Tessian outbound 31df1b57f90c:v228"); Thu, 01 Feb 2024 08:01:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 87569f1b952581a1
X-CR-MTA-TID: 64aa7808
Received: from 1e2d6f3a6707.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 529F8B03-AD5D-4D21-BAD1-044AB55085ED.1;
	Thu, 01 Feb 2024 08:01:06 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1e2d6f3a6707.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 01 Feb 2024 08:01:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja1UEAxb/IBsdnoZgyqUkGBCcWc8yyDOSHLWQ6E+vBzTbN9ualRyPNOzjeuam/KIbRGwWgj0zjC8rRDkaBw5MbA5IGFArCaEnUJ2TpHe/29un7Jo5FO1DDPu7h3kIGV8Z+WbTOPuevfpqh25eF9A9NH1XfjJQn9y9RK7U0+R8+6W8HoNEUO3b6qgKmvpiAzTl3P0pzjGz/sKRNgj2dsjQZReMe/LQtt7nu3fGEDIXB8/WULnJOIFH7BBtEPfMPC6/CdBD4+XcBuRbYdnJda+TJaZ707C6G22PYZu5qqfnQPtqezgSm3ilYhNNsBFxu6PDLyk2lP3AgRxVoR72qQqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFFYoBB4PMIq1taHw7IQAEuPC5tfXYRY1wnyqLat63s=;
 b=brbFZ10LDeCJp3RQI0DOFIj9Wc1RjhIMijSHbghBVAz1kFu0/UExt/f/KdSmpJlhZWHkiwUGyE+7Pe6fHbFJVRhoBnkZiLXe+Tc40JhN6FnY0k1PwSJNvrI4jTH7c8mKbLWz/+tt9nnJFQ4hW4XwM39qfrZYf/n6Jhc23qyLq2mm9lY2X8z1DAE23R+/uyPwj9+Ml5Vk15pdk+Uj7BmnYphrwtuYMG9lW00eA106ncvvB3cwyTXKFPuFntpjoiwKsUyhzUi6rkg/Et/OKKONG893T3Fu82ENkU3VIMqln9nN+54SPIZdnQUD7TGtajdXSt/a8Q8YNdU1MaHPruTdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFFYoBB4PMIq1taHw7IQAEuPC5tfXYRY1wnyqLat63s=;
 b=XmMZV13Z54lPKk27j0Oc6h84JW2nvsiZbnoIsxn/xnd49blRi5dRl8ZHRjb6GP97i1KT6GO2Pd93cwuY42/7OkqwNnZmHIddmB843zvyPtzaVquXg03p/yFFC+DxGByFQZS7V4oeR3Xs0odUgP/W1X8jtelwVgjWOPu1NuUy/tU=
Received: from VI1PR08MB3101.eurprd08.prod.outlook.com (2603:10a6:803:45::32)
 by AS8PR08MB6182.eurprd08.prod.outlook.com (2603:10a6:20b:291::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 08:01:02 +0000
Received: from VI1PR08MB3101.eurprd08.prod.outlook.com
 ([fe80::80b2:80ee:310c:2cb]) by VI1PR08MB3101.eurprd08.prod.outlook.com
 ([fe80::80b2:80ee:310c:2cb%5]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 08:01:02 +0000
From: Lukasz Okraszewski <Lukasz.Okraszewski@arm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Matthew
 Clarkson <Matthew.Clarkson@arm.com>, Brandon Jones <Brandon.Jones@arm.com>,
	nd <nd@arm.com>, overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [overlay] [fuse] Potential bug with large file support for FUSE
 based lowerdir
Thread-Topic: [overlay] [fuse] Potential bug with large file support for FUSE
 based lowerdir
Thread-Index: AQHaVGOz8JYJ8ZNYjU282lashynInbD0VE8AgADKtBw=
Date: Thu, 1 Feb 2024 08:01:02 +0000
Message-ID:
 <VI1PR08MB3101A133BDF889B35F14D28882432@VI1PR08MB3101.eurprd08.prod.outlook.com>
References:
 <VI1PR08MB31011DF4722B9E720A251892827C2@VI1PR08MB3101.eurprd08.prod.outlook.com>
 <CAJfpegvBc+Md51ubYv9iDnST+Xps9P=g51NcWJONKy4fq=O8+Q@mail.gmail.com>
In-Reply-To:
 <CAJfpegvBc+Md51ubYv9iDnST+Xps9P=g51NcWJONKy4fq=O8+Q@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	VI1PR08MB3101:EE_|AS8PR08MB6182:EE_|AMS0EPF000001A9:EE_|DB5PR08MB10215:EE_
X-MS-Office365-Filtering-Correlation-Id: d1bf968e-5e21-4caa-3b44-08dc22fbf856
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 Ps2mZpV0oZ5vAJL9CXDYAqoc1I7Fkk+fwo3XqfzsLF1hol5TySXdFNPfEoquA3yiDdpGKS5/SppGG010Hukaz/tFyaRhdg2ngCLKLkQI9DOjeGdG93QxxCbzmeO0YdnwVw7rTd8uPXW720W9+Tkzzo+HAwb67SjODq0E6Ftc6lsaEbGZVx1nProldiBDEtlbsKPyj32u+cGu5HoT9/9FrB/UMPCvH/qubPIUKbl8Yapw7usH+SyNvNMomTAb6ylN1928ms5VnTbm2ptGs1McI7UlfjgyJ8l/QbsOCoioVYV3gG+Eo3xLBh3FjKAO+cdYDQtpKrjOVtyXVRIArRGqEmM3x1X81TMsOrC/EYPnF2UG4AgYDd0rR8AyZCd+o4Si0lNsw4Y9UIiwXnwlZiRqTbSQXmFWkS/tChejGZvPS62COkYsk9EfL9GfWfbr3XPseDra7Rxusjtmo/RCjtW/avtgzN51bADB63kwyTJCCAqs8z0p/96TQYMY6SJXmFs3zFl6MZzSHJNLSeW2JjsgwBdv5cMKNAhtijzUHRNUogOqU3uKgmbxsRQGwr3hYGIbQn+SQq/jc5H2b5Xc5/4rROb+BsGS2TfHsrA2PqH4FUD5gNbxlxWeK/lwFQ5jMlZq
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3101.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(26005)(2906002)(99936003)(33656002)(38070700009)(41300700001)(4744005)(55016003)(83380400001)(66476007)(91956017)(8936002)(64756008)(54906003)(6916009)(66446008)(8676002)(66946007)(316002)(66556008)(6506007)(76116006)(9686003)(38100700002)(478600001)(71200400001)(7696005)(4326008)(5660300002)(52536014)(122000001);DIR:OUT;SFP:1101;
Content-Type: multipart/mixed;
	boundary="_004_VI1PR08MB3101A133BDF889B35F14D28882432VI1PR08MB3101eurp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6182
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9a826b23-6607-41f8-ac61-08dc22fbef27
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WS/+iRCTjtXSe4Qh5OZGwzUTEQvxmNiUK7EiEt5Pn0vIpw1cD1RIOM/gktgVeJyD6I/2agFZ9D50lwGgMErzmB612Y/vx9rHwCVK6gCcjEyVhnYChciv7yjz6zGv99mA/YIh8yUUhnOWzVbxrFGBB58okvkI36Yq17IRcFvannNcGyaVjcI/FVZqv7+eGa14423JMMPbirsIdXc+8U207kdJ8p7dsvzbeP3iuWHoVjkaVRBAIZY3cuhh+FxgHjqde6mQ+55x+viEL9o46Umx8xf4fWhwx0m+fs8oUT45t1RTEqp9oqJt/AEPBbAktAbdAJF1cRHMaMTFE382lfUInyQaxszCScGE51MiRVLKIVzF5jaPdc0szCdQomxIdSry+tJ+8pnwffXCI+EZjiG6CIdt00BmPFO8S88Wm9vVmCW/pzqqAXB642HefCYskb8AqrRLleKMkakB2E1hFqEdsIVzJNJfRIoGFW9j1mgeXTBhKs0X2S+Ruqjn0YJlhOmThoozVXjG+t1AznLXvbZx5J6PFXlWLimABKQ94ywC43YM97PI76xes49eSYMNtauw4oX1mVTHm0cJXKG9MohnZtVkRHCIYU3PnzWBLhRd+W1qqGHYnBUAVQnv46iiBxdUrPYnV2yK4fTzAMLkRyVJ5fYHtNMTdPj2HiMnANRAXxS++yR9TnPkRNvDNl/kuvbdx8snGuDMOOAddXbSB9aWEAOEoMDBnFwOfhJa/OOzTzR9zxo+MV6VN7E6bHjnIuoz
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39850400004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(40470700004)(46966006)(36840700001)(83380400001)(47076005)(21480400003)(36860700001)(9686003)(336012)(26005)(356005)(82740400003)(99936003)(450100002)(52536014)(5660300002)(6862004)(8676002)(8936002)(235185007)(4326008)(2906002)(6506007)(70586007)(7696005)(478600001)(54906003)(70206006)(316002)(81166007)(33656002)(41300700001)(86362001)(55016003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 08:01:17.7366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bf968e-5e21-4caa-3b44-08dc22fbf856
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10215

--_004_VI1PR08MB3101A133BDF889B35F14D28882432VI1PR08MB3101eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> So this is a FUSE_IOCTL/FS_IOC_GETFLAGS request for which the server=0A=
> replies with EOVERFLOW.=A0 This looks like a server issue, but it would=
=0A=
> be good to see the logs and/or strace related to this particular=0A=
> request.=0A=
> =0A=
> Thanks,=0A=
> Miklos=0A=
=0A=
Thanks for having a look!=0A=
=0A=
I have attached the logs. I am running two lower dirs but I don't think it =
should matter. =0A=
For clarify the steps were:=0A=
```=0A=
squashfuse -o allow_other large1.squashfs work/lower1 -d  2>&1 | tee /tmp/l=
ower1.log=0A=
squashfuse -o allow_other large2.squashfs work/lower2 -d  2>&1 | tee /tmp/l=
ower2.log=0A=
sudo mount \=0A=
  -t overlay \=0A=
  -o lowerdir=3Dwork/lower2:work/lower1:work/lower0,upperdir=3Dwork/upper,w=
orkdir=3Dwork/work\=0A=
  overlay \=0A=
  work/mnt=0A=
cd work/mnt=0A=
strace dd if=3D/dev/zero of=3Dtest.file bs=3D4k count=3D80  2>&1 | tee /tmp=
/strace.log=0A=
```=0A=
=0A=
Kind regards,=0A=
Lukasz=

--_004_VI1PR08MB3101A133BDF889B35F14D28882432VI1PR08MB3101eurp_
Content-Type: application/octet-stream; name="lower2.log"
Content-Description: lower2.log
Content-Disposition: attachment; filename="lower2.log"; size=1875;
	creation-date="Thu, 01 Feb 2024 08:00:12 GMT";
	modification-date="Thu, 01 Feb 2024 08:00:12 GMT"
Content-Transfer-Encoding: base64

RlVTRSBsaWJyYXJ5IHZlcnNpb246IDMuMTAuNQpudWxscGF0aF9vazogMAp1bmlxdWU6IDIsIG9w
Y29kZTogSU5JVCAoMjYpLCBub2RlaWQ6IDAsIGluc2l6ZTogNTYsIHBpZDogMApJTklUOiA3LjM0
CmZsYWdzPTB4MzNmZmZmZmIKbWF4X3JlYWRhaGVhZD0weDAwMDIwMDAwCiAgIElOSVQ6IDcuMzEK
ICAgZmxhZ3M9MHgwMDQwZjAzOQogICBtYXhfcmVhZGFoZWFkPTB4MDAwMjAwMDAKICAgbWF4X3dy
aXRlPTB4MDAxMDAwMDAKICAgbWF4X2JhY2tncm91bmQ9MAogICBjb25nZXN0aW9uX3RocmVzaG9s
ZD0wCiAgIHRpbWVfZ3Jhbj0xCiAgIHVuaXF1ZTogMiwgc3VjY2Vzcywgb3V0c2l6ZTogODAKdW5p
cXVlOiA0LCBvcGNvZGU6IFNUQVRGUyAoMTcpLCBub2RlaWQ6IDEsIGluc2l6ZTogNDAsIHBpZDog
MTU2NTY3NwpzdGF0ZnMgLwpzdC0+Zl9ic2l6ZSAgKDEzMTA3MikKc3QtPmZfZnJzaXplICgxMzEw
NzIpCnN0LT5mX2Jsb2NrcyAoNTIpCnN0LT5mX2ZpbGVzICAoMikKc3QtPmZfbmFtZW1heCAgKDI1
NikKICAgdW5pcXVlOiA0LCBzdWNjZXNzLCBvdXRzaXplOiA5Ngp1bmlxdWU6IDYsIG9wY29kZTog
TE9PS1VQICgxKSwgbm9kZWlkOiAxLCBpbnNpemU6IDQ1LCBwaWQ6IDM3MjQzMzcKTE9PS1VQIC8u
Z2l0CmdldGF0dHJbTlVMTF0gLy5naXQKICAgdW5pcXVlOiA2LCBlcnJvcjogLTIgKE5vIHN1Y2gg
ZmlsZSBvciBkaXJlY3RvcnkpLCBvdXRzaXplOiAxNgp1bmlxdWU6IDgsIG9wY29kZTogTE9PS1VQ
ICgxKSwgbm9kZWlkOiAxLCBpbnNpemU6IDQ0LCBwaWQ6IDM3MjM2NjIKTE9PS1VQIC9pZj0KZ2V0
YXR0cltOVUxMXSAvaWY9CiAgIHVuaXF1ZTogOCwgZXJyb3I6IC0yIChObyBzdWNoIGZpbGUgb3Ig
ZGlyZWN0b3J5KSwgb3V0c2l6ZTogMTYKdW5pcXVlOiAxMCwgb3Bjb2RlOiBMT09LVVAgKDEpLCBu
b2RlaWQ6IDEsIGluc2l6ZTogNTMsIHBpZDogMzcyMzY2MgpMT09LVVAgL29mPXRlc3QuZmlsZQpn
ZXRhdHRyW05VTExdIC9vZj10ZXN0LmZpbGUKICAgdW5pcXVlOiAxMCwgZXJyb3I6IC0yIChObyBz
dWNoIGZpbGUgb3IgZGlyZWN0b3J5KSwgb3V0c2l6ZTogMTYKdW5pcXVlOiAxMiwgb3Bjb2RlOiBM
T09LVVAgKDEpLCBub2RlaWQ6IDEsIGluc2l6ZTogNDYsIHBpZDogMzcyMzY2MgpMT09LVVAgL2Jz
PTRrCmdldGF0dHJbTlVMTF0gL2JzPTRrCiAgIHVuaXF1ZTogMTIsIGVycm9yOiAtMiAoTm8gc3Vj
aCBmaWxlIG9yIGRpcmVjdG9yeSksIG91dHNpemU6IDE2CnVuaXF1ZTogMTQsIG9wY29kZTogTE9P
S1VQICgxKSwgbm9kZWlkOiAxLCBpbnNpemU6IDQ5LCBwaWQ6IDM3MjM2NjIKTE9PS1VQIC9jb3Vu
dD04MApnZXRhdHRyW05VTExdIC9jb3VudD04MAogICB1bmlxdWU6IDE0LCBlcnJvcjogLTIgKE5v
IHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpLCBvdXRzaXplOiAxNgp1bmlxdWU6IDE2LCBvcGNvZGU6
IExPT0tVUCAoMSksIG5vZGVpZDogMSwgaW5zaXplOiA1MCwgcGlkOiAxNTY2Mjc0CkxPT0tVUCAv
dGVzdC5maWxlCmdldGF0dHJbTlVMTF0gL3Rlc3QuZmlsZQogICBOT0RFSUQ6IDIKICAgdW5pcXVl
OiAxNiwgc3VjY2Vzcywgb3V0c2l6ZTogMTQ0CnVuaXF1ZTogMTgsIG9wY29kZTogR0VUWEFUVFIg
KDIyKSwgbm9kZWlkOiAyLCBpbnNpemU6IDczLCBwaWQ6IDE1NjYyNzQKZ2V0eGF0dHIgL3Rlc3Qu
ZmlsZSB0cnVzdGVkLm92ZXJsYXkubWV0YWNvcHkgMAogICB1bmlxdWU6IDE4LCBlcnJvcjogLTYx
IChObyBkYXRhIGF2YWlsYWJsZSksIG91dHNpemU6IDE2CnVuaXF1ZTogMjAsIG9wY29kZTogTElT
VFhBVFRSICgyMyksIG5vZGVpZDogMiwgaW5zaXplOiA0OCwgcGlkOiAxNTY2Mjc0Cmxpc3R4YXR0
ciAvdGVzdC5maWxlIDAKICAgdW5pcXVlOiAyMCwgc3VjY2Vzcywgb3V0c2l6ZTogMjQK

--_004_VI1PR08MB3101A133BDF889B35F14D28882432VI1PR08MB3101eurp_
Content-Type: application/octet-stream; name="strace.log"
Content-Description: strace.log
Content-Disposition: attachment; filename="strace.log"; size=5407;
	creation-date="Thu, 01 Feb 2024 08:00:12 GMT";
	modification-date="Thu, 01 Feb 2024 08:00:12 GMT"
Content-Transfer-Encoding: base64

ZXhlY3ZlKCIvdXNyL2Jpbi9kZCIsIFsiZGQiLCAiaWY9L2Rldi96ZXJvIiwgIm9mPXRlc3QuZmls
ZSIsICJicz00ayIsICJjb3VudD04MCJdLCAweDdmZmY1ZDNlMGMyMCAvKiA5NSB2YXJzICovKSA9
IDAKYnJrKE5VTEwpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMHg1NjE0ZDA0MzQw
MDAKYXJjaF9wcmN0bCgweDMwMDEgLyogQVJDSF8/Pz8gKi8sIDB4N2ZmZTMzM2IzNjQwKSA9IC0x
IEVJTlZBTCAoSW52YWxpZCBhcmd1bWVudCkKbW1hcChOVUxMLCA4MTkyLCBQUk9UX1JFQUR8UFJP
VF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VUywgLTEsIDApID0gMHg3ZjUyYWZiNzkw
MDAKYWNjZXNzKCIvZXRjL2xkLnNvLnByZWxvYWQiLCBSX09LKSAgICAgID0gLTEgRU5PRU5UIChO
byBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuYXQoQVRfRkRDV0QsICIvZXRjL2xkLnNvLmNh
Y2hlIiwgT19SRE9OTFl8T19DTE9FWEVDKSA9IDMKbmV3ZnN0YXRhdCgzLCAiIiwge3N0X21vZGU9
U19JRlJFR3wwNjQ0LCBzdF9zaXplPTkxMjYzLCAuLi59LCBBVF9FTVBUWV9QQVRIKSA9IDAKbW1h
cChOVUxMLCA5MTI2MywgUFJPVF9SRUFELCBNQVBfUFJJVkFURSwgMywgMCkgPSAweDdmNTJhZmI2
MjAwMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCm9wZW5hdChB
VF9GRENXRCwgIi9saWIveDg2XzY0LWxpbnV4LWdudS9saWJjLnNvLjYiLCBPX1JET05MWXxPX0NM
T0VYRUMpID0gMwpyZWFkKDMsICJcMTc3RUxGXDJcMVwxXDNcMFwwXDBcMFwwXDBcMFwwXDNcMD5c
MFwxXDBcMFwwUFwyMzdcMlwwXDBcMFwwXDAiLi4uLCA4MzIpID0gODMyCnByZWFkNjQoMywgIlw2
XDBcMFwwXDRcMFwwXDBAXDBcMFwwXDBcMFwwXDBAXDBcMFwwXDBcMFwwXDBAXDBcMFwwXDBcMFww
XDAiLi4uLCA3ODQsIDY0KSA9IDc4NApwcmVhZDY0KDMsICJcNFwwXDBcMCBcMFwwXDBcNVwwXDBc
MEdOVVwwXDJcMFwwXDMwMFw0XDBcMFwwXDNcMFwwXDBcMFwwXDBcMCIuLi4sIDQ4LCA4NDgpID0g
NDgKcHJlYWQ2NCgzLCAiXDRcMFwwXDBcMjRcMFwwXDBcM1wwXDBcMEdOVVwwXDMwMlwyMTFcMzMy
UHFcMjQzOVwyMzVcMzUwXDIyM1wzMjJcMjU3XDIwMVwzMjZcMjQzXGYiLi4uLCA2OCwgODk2KSA9
IDY4Cm5ld2ZzdGF0YXQoMywgIiIsIHtzdF9tb2RlPVNfSUZSRUd8MDc1NSwgc3Rfc2l6ZT0yMjIw
NDAwLCAuLi59LCBBVF9FTVBUWV9QQVRIKSA9IDAKcHJlYWQ2NCgzLCAiXDZcMFwwXDBcNFwwXDBc
MEBcMFwwXDBcMFwwXDBcMEBcMFwwXDBcMFwwXDBcMEBcMFwwXDBcMFwwXDBcMCIuLi4sIDc4NCwg
NjQpID0gNzg0Cm1tYXAoTlVMTCwgMjI2NDY1NiwgUFJPVF9SRUFELCBNQVBfUFJJVkFURXxNQVBf
REVOWVdSSVRFLCAzLCAwKSA9IDB4N2Y1MmFmOTM5MDAwCm1wcm90ZWN0KDB4N2Y1MmFmOTYxMDAw
LCAyMDIzNDI0LCBQUk9UX05PTkUpID0gMAptbWFwKDB4N2Y1MmFmOTYxMDAwLCAxNjU4ODgwLCBQ
Uk9UX1JFQUR8UFJPVF9FWEVDLCBNQVBfUFJJVkFURXxNQVBfRklYRUR8TUFQX0RFTllXUklURSwg
MywgMHgyODAwMCkgPSAweDdmNTJhZjk2MTAwMAptbWFwKDB4N2Y1MmFmYWY2MDAwLCAzNjA0NDgs
IFBST1RfUkVBRCwgTUFQX1BSSVZBVEV8TUFQX0ZJWEVEfE1BUF9ERU5ZV1JJVEUsIDMsIDB4MWJk
MDAwKSA9IDB4N2Y1MmFmYWY2MDAwCm1tYXAoMHg3ZjUyYWZiNGYwMDAsIDI0NTc2LCBQUk9UX1JF
QUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0ZJWEVEfE1BUF9ERU5ZV1JJVEUsIDMsIDB4
MjE1MDAwKSA9IDB4N2Y1MmFmYjRmMDAwCm1tYXAoMHg3ZjUyYWZiNTUwMDAsIDUyODE2LCBQUk9U
X1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0ZJWEVEfE1BUF9BTk9OWU1PVVMsIC0x
LCAwKSA9IDB4N2Y1MmFmYjU1MDAwCmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA9IDAKbW1hcChOVUxMLCAxMjI4OCwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklW
QVRFfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4N2Y1MmFmOTM2MDAwCmFyY2hfcHJjdGwoQVJD
SF9TRVRfRlMsIDB4N2Y1MmFmOTM2NzQwKSA9IDAKc2V0X3RpZF9hZGRyZXNzKDB4N2Y1MmFmOTM2
YTEwKSAgICAgICAgID0gMTU2NjI3NApzZXRfcm9idXN0X2xpc3QoMHg3ZjUyYWY5MzZhMjAsIDI0
KSAgICAgPSAwCnJzZXEoMHg3ZjUyYWY5MzcwZTAsIDB4MjAsIDAsIDB4NTMwNTMwNTMpID0gMApt
cHJvdGVjdCgweDdmNTJhZmI0ZjAwMCwgMTYzODQsIFBST1RfUkVBRCkgPSAwCm1wcm90ZWN0KDB4
NTYxNGNmN2I1MDAwLCA0MDk2LCBQUk9UX1JFQUQpID0gMAptcHJvdGVjdCgweDdmNTJhZmJiMzAw
MCwgODE5MiwgUFJPVF9SRUFEKSA9IDAKcHJsaW1pdDY0KDAsIFJMSU1JVF9TVEFDSywgTlVMTCwg
e3JsaW1fY3VyPTgxOTIqMTAyNCwgcmxpbV9tYXg9UkxJTTY0X0lORklOSVRZfSkgPSAwCm11bm1h
cCgweDdmNTJhZmI2MjAwMCwgOTEyNjMpICAgICAgICAgICA9IDAKcnRfc2lnYWN0aW9uKFNJR0lO
VCwgTlVMTCwge3NhX2hhbmRsZXI9U0lHX0RGTCwgc2FfbWFzaz1bXSwgc2FfZmxhZ3M9MH0sIDgp
ID0gMApydF9zaWdhY3Rpb24oU0lHVVNSMSwge3NhX2hhbmRsZXI9MHg1NjE0Y2Y3YTk5MDAsIHNh
X21hc2s9W0lOVCBVU1IxXSwgc2FfZmxhZ3M9U0FfUkVTVE9SRVIsIHNhX3Jlc3RvcmVyPTB4N2Y1
MmFmOTdiNTIwfSwgTlVMTCwgOCkgPSAwCnJ0X3NpZ2FjdGlvbihTSUdJTlQsIHtzYV9oYW5kbGVy
PTB4NTYxNGNmN2E5OGYwLCBzYV9tYXNrPVtJTlQgVVNSMV0sIHNhX2ZsYWdzPVNBX1JFU1RPUkVS
fFNBX05PREVGRVJ8U0FfUkVTRVRIQU5EfDB4ZmZmZmZmZmYwMDAwMDAwMCwgc2FfcmVzdG9yZXI9
MHg3ZjUyYWY5N2I1MjB9LCBOVUxMLCA4KSA9IDAKZ2V0cmFuZG9tKCJceDA3XHg4N1x4YjhceGZh
XHgzMlx4YTNceDFlXHg5MSIsIDgsIEdSTkRfTk9OQkxPQ0spID0gOApicmsoTlVMTCkgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgPSAweDU2MTRkMDQzNDAwMApicmsoMHg1NjE0ZDA0NTUw
MDApICAgICAgICAgICAgICAgICAgICAgPSAweDU2MTRkMDQ1NTAwMApvcGVuYXQoQVRfRkRDV0Qs
ICIvdXNyL2xpYi9sb2NhbGUvbG9jYWxlLWFyY2hpdmUiLCBPX1JET05MWXxPX0NMT0VYRUMpID0g
MwpuZXdmc3RhdGF0KDMsICIiLCB7c3RfbW9kZT1TX0lGUkVHfDA2NDQsIHN0X3NpemU9NTcxMjIw
OCwgLi4ufSwgQVRfRU1QVFlfUEFUSCkgPSAwCm1tYXAoTlVMTCwgNTcxMjIwOCwgUFJPVF9SRUFE
LCBNQVBfUFJJVkFURSwgMywgMCkgPSAweDdmNTJhZjNjMzAwMApjbG9zZSgzKSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgPSAwCm9wZW5hdChBVF9GRENXRCwgIi9kZXYvemVybyIsIE9f
UkRPTkxZKSA9IDMKZHVwMigzLCAwKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMApj
bG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCmxzZWVrKDAsIDAsIFNF
RUtfQ1VSKSAgICAgICAgICAgICAgICAgICA9IDAKb3BlbmF0KEFUX0ZEQ1dELCAidGVzdC5maWxl
IiwgT19XUk9OTFl8T19DUkVBVHxPX1RSVU5DLCAwNjY2KSA9IC0xIEVPVkVSRkxPVyAoVmFsdWUg
dG9vIGxhcmdlIGZvciBkZWZpbmVkIGRhdGEgdHlwZSkKb3BlbmF0KEFUX0ZEQ1dELCAiL3Vzci9z
aGFyZS9sb2NhbGUvbG9jYWxlLmFsaWFzIiwgT19SRE9OTFl8T19DTE9FWEVDKSA9IDMKbmV3ZnN0
YXRhdCgzLCAiIiwge3N0X21vZGU9U19JRlJFR3wwNjQ0LCBzdF9zaXplPTI5OTYsIC4uLn0sIEFU
X0VNUFRZX1BBVEgpID0gMApyZWFkKDMsICIjIExvY2FsZSBuYW1lIGFsaWFzIGRhdGEgYmFzZS5c
biMiLi4uLCA0MDk2KSA9IDI5OTYKcmVhZCgzLCAiIiwgNDA5NikgICAgICAgICAgICAgICAgICAg
ICAgID0gMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCm9wZW5h
dChBVF9GRENXRCwgIi91c3Ivc2hhcmUvbG9jYWxlL2VuX1VTL0xDX01FU1NBR0VTL2NvcmV1dGls
cy5tbyIsIE9fUkRPTkxZKSA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkK
b3BlbmF0KEFUX0ZEQ1dELCAiL3Vzci9zaGFyZS9sb2NhbGUvZW4vTENfTUVTU0FHRVMvY29yZXV0
aWxzLm1vIiwgT19SRE9OTFkpID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5
KQpvcGVuYXQoQVRfRkRDV0QsICIvdXNyL3NoYXJlL2xvY2FsZS1sYW5ncGFjay9lbl9VUy9MQ19N
RVNTQUdFUy9jb3JldXRpbHMubW8iLCBPX1JET05MWSkgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmls
ZSBvciBkaXJlY3RvcnkpCm9wZW5hdChBVF9GRENXRCwgIi91c3Ivc2hhcmUvbG9jYWxlLWxhbmdw
YWNrL2VuL0xDX01FU1NBR0VTL2NvcmV1dGlscy5tbyIsIE9fUkRPTkxZKSA9IDMKbmV3ZnN0YXRh
dCgzLCAiIiwge3N0X21vZGU9U19JRlJFR3wwNjQ0LCBzdF9zaXplPTYxMywgLi4ufSwgQVRfRU1Q
VFlfUEFUSCkgPSAwCm1tYXAoTlVMTCwgNjEzLCBQUk9UX1JFQUQsIE1BUF9QUklWQVRFLCAzLCAw
KSA9IDB4N2Y1MmFmYmIyMDAwCmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA9IDAKd3JpdGUoMiwgImRkOiAiLCA0ZGQ6ICkgICAgICAgICAgICAgICAgICAgICA9IDQKd3Jp
dGUoMiwgImZhaWxlZCB0byBvcGVuICd0ZXN0LmZpbGUnIiwgMjZmYWlsZWQgdG8gb3BlbiAndGVz
dC5maWxlJykgPSAyNgpvcGVuYXQoQVRfRkRDV0QsICIvdXNyL3NoYXJlL2xvY2FsZS9lbl9VUy9M
Q19NRVNTQUdFUy9saWJjLm1vIiwgT19SRE9OTFkpID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUg
b3IgZGlyZWN0b3J5KQpvcGVuYXQoQVRfRkRDV0QsICIvdXNyL3NoYXJlL2xvY2FsZS9lbi9MQ19N
RVNTQUdFUy9saWJjLm1vIiwgT19SRE9OTFkpID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3Ig
ZGlyZWN0b3J5KQpvcGVuYXQoQVRfRkRDV0QsICIvdXNyL3NoYXJlL2xvY2FsZS1sYW5ncGFjay9l
bl9VUy9MQ19NRVNTQUdFUy9saWJjLm1vIiwgT19SRE9OTFkpID0gLTEgRU5PRU5UIChObyBzdWNo
IGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuYXQoQVRfRkRDV0QsICIvdXNyL3NoYXJlL2xvY2FsZS1s
YW5ncGFjay9lbi9MQ19NRVNTQUdFUy9saWJjLm1vIiwgT19SRE9OTFkpID0gLTEgRU5PRU5UIChO
byBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQp3cml0ZSgyLCAiOiBWYWx1ZSB0b28gbGFyZ2UgZm9y
IGRlZmluZWQgZGEiLi4uLCAzOTogVmFsdWUgdG9vIGxhcmdlIGZvciBkZWZpbmVkIGRhdGEgdHlw
ZSkgPSAzOQp3cml0ZSgyLCAiXG4iLCAxCikgICAgICAgICAgICAgICAgICAgICAgID0gMQpjbG9z
ZSgyKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCmV4aXRfZ3JvdXAoMSkgICAg
ICAgICAgICAgICAgICAgICAgICAgICA9ID8KKysrIGV4aXRlZCB3aXRoIDEgKysrCg==

--_004_VI1PR08MB3101A133BDF889B35F14D28882432VI1PR08MB3101eurp_
Content-Type: application/octet-stream; name="lower1.log"
Content-Description: lower1.log
Content-Disposition: attachment; filename="lower1.log"; size=1406;
	creation-date="Thu, 01 Feb 2024 08:00:12 GMT";
	modification-date="Thu, 01 Feb 2024 08:00:12 GMT"
Content-Transfer-Encoding: base64

RlVTRSBsaWJyYXJ5IHZlcnNpb246IDMuMTAuNQpudWxscGF0aF9vazogMAp1bmlxdWU6IDIsIG9w
Y29kZTogSU5JVCAoMjYpLCBub2RlaWQ6IDAsIGluc2l6ZTogNTYsIHBpZDogMApJTklUOiA3LjM0
CmZsYWdzPTB4MzNmZmZmZmIKbWF4X3JlYWRhaGVhZD0weDAwMDIwMDAwCiAgIElOSVQ6IDcuMzEK
ICAgZmxhZ3M9MHgwMDQwZjAzOQogICBtYXhfcmVhZGFoZWFkPTB4MDAwMjAwMDAKICAgbWF4X3dy
aXRlPTB4MDAxMDAwMDAKICAgbWF4X2JhY2tncm91bmQ9MAogICBjb25nZXN0aW9uX3RocmVzaG9s
ZD0wCiAgIHRpbWVfZ3Jhbj0xCiAgIHVuaXF1ZTogMiwgc3VjY2Vzcywgb3V0c2l6ZTogODAKdW5p
cXVlOiA0LCBvcGNvZGU6IFNUQVRGUyAoMTcpLCBub2RlaWQ6IDEsIGluc2l6ZTogNDAsIHBpZDog
MTU2NTY3NwpzdGF0ZnMgLwpzdC0+Zl9ic2l6ZSAgKDEzMTA3MikKc3QtPmZfZnJzaXplICgxMzEw
NzIpCnN0LT5mX2Jsb2NrcyAoNTIpCnN0LT5mX2ZpbGVzICAoMikKc3QtPmZfbmFtZW1heCAgKDI1
NikKICAgdW5pcXVlOiA0LCBzdWNjZXNzLCBvdXRzaXplOiA5Ngp1bmlxdWU6IDYsIG9wY29kZTog
TE9PS1VQICgxKSwgbm9kZWlkOiAxLCBpbnNpemU6IDQ1LCBwaWQ6IDM3MjQzMzcKTE9PS1VQIC8u
Z2l0CmdldGF0dHJbTlVMTF0gLy5naXQKICAgdW5pcXVlOiA2LCBlcnJvcjogLTIgKE5vIHN1Y2gg
ZmlsZSBvciBkaXJlY3RvcnkpLCBvdXRzaXplOiAxNgp1bmlxdWU6IDgsIG9wY29kZTogTE9PS1VQ
ICgxKSwgbm9kZWlkOiAxLCBpbnNpemU6IDQ0LCBwaWQ6IDM3MjM2NjIKTE9PS1VQIC9pZj0KZ2V0
YXR0cltOVUxMXSAvaWY9CiAgIHVuaXF1ZTogOCwgZXJyb3I6IC0yIChObyBzdWNoIGZpbGUgb3Ig
ZGlyZWN0b3J5KSwgb3V0c2l6ZTogMTYKdW5pcXVlOiAxMCwgb3Bjb2RlOiBMT09LVVAgKDEpLCBu
b2RlaWQ6IDEsIGluc2l6ZTogNTMsIHBpZDogMzcyMzY2MgpMT09LVVAgL29mPXRlc3QuZmlsZQpn
ZXRhdHRyW05VTExdIC9vZj10ZXN0LmZpbGUKICAgdW5pcXVlOiAxMCwgZXJyb3I6IC0yIChObyBz
dWNoIGZpbGUgb3IgZGlyZWN0b3J5KSwgb3V0c2l6ZTogMTYKdW5pcXVlOiAxMiwgb3Bjb2RlOiBM
T09LVVAgKDEpLCBub2RlaWQ6IDEsIGluc2l6ZTogNDYsIHBpZDogMzcyMzY2MgpMT09LVVAgL2Jz
PTRrCmdldGF0dHJbTlVMTF0gL2JzPTRrCiAgIHVuaXF1ZTogMTIsIGVycm9yOiAtMiAoTm8gc3Vj
aCBmaWxlIG9yIGRpcmVjdG9yeSksIG91dHNpemU6IDE2CnVuaXF1ZTogMTQsIG9wY29kZTogTE9P
S1VQICgxKSwgbm9kZWlkOiAxLCBpbnNpemU6IDQ5LCBwaWQ6IDM3MjM2NjIKTE9PS1VQIC9jb3Vu
dD04MApnZXRhdHRyW05VTExdIC9jb3VudD04MAogICB1bmlxdWU6IDE0LCBlcnJvcjogLTIgKE5v
IHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpLCBvdXRzaXplOiAxNgo=

--_004_VI1PR08MB3101A133BDF889B35F14D28882432VI1PR08MB3101eurp_--

