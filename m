Return-Path: <linux-fsdevel+bounces-10336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B8849F7D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 17:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2635C1F2339E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906A8374F5;
	Mon,  5 Feb 2024 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eGkemGGq";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eGkemGGq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65132EB08;
	Mon,  5 Feb 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150654; cv=fail; b=OrQmnwrbGp6CdZ2U74kVINRXRQyGMGVhEErJmSj9miqd8G6tIm89cN4ts4xiBxSSlfX2EsS94xUeMKWd5ulyTb/Je6jdtG1BJezIXRjkJO63WRuYcuXSUBVCf15A7EF+aoQ0oExim4T7GvFssS7s8WJW3hsCTn2Qx+8CNmyYUac=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150654; c=relaxed/simple;
	bh=J7AhrdpTKkNelVOnDNxZeOOyW0EB33IuTI/khrTRcVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kFW8stKXY2YluUt+yZjeIMAiV6TurN31zOE4bjAnuJGukoOLPe30aFiJ4Yvfg1VE0rK4aVsnxlbEeG1ekhbZadin9Hwqv23lnrg5OZFRpv0To8d2bHluFg6PfL1VYRRkNDNFWO6Z1sB/zjOEIlRr1TVUizVmJauYz8Cg7p6ARm0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=eGkemGGq; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=eGkemGGq; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=gURm5mSu6iAUZHFtjfSem6I6YCrf3jyp7H8s0AJAVhxzYDqoe6XaEsmn+6frUmFJ8/dmMsV47WKvbClSZLAYMnt2ZeyX/V1ZkDC+ZNbT+8vVL5CpYw7xVWhQhfKn77q3ZSfOsH3SjFHFjdhoMNp45NHi9cPh+ktPYv7e77JNE8aNnz2AQB9kUH1FhcYGW6ot7ONDP+Cqx6Ply7y+T3IzhWD9y1FadDzLOGa7J0+ua/7sSstcQeAB8KUufpS4BL9F+589j3sZbiJGPup5ac2sCpLPkV5Ut1aEOTOrxPReqlz3DJoQ4oUprP2ZeF9ejwq2usbd1CugZM3tSU7MWD+p5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKFJxZ2+kCIPS11EhpwNvCR59jz94fC2Zn1gD1Ogz8I=;
 b=gzhJl7I4StQLNNQA78d13yh5iXQKCJCkMvOEgVgJcOHJMK21q91orohVGoieH0WfptYjWND9loxFb/vTh0NWN5yPYXdirJxd3QhdI0Lk+Gy72Rd6ptfBkLS1Z/+mx/wN1x5z7vq7gmfPkcFjloB1FS7nYlsjsSUbVNI9EztJ2MxfdQiZovx4MPC3nhDz8DnOMhlh7WXQaBlvMVS1UdvGotA8VEQUbxAtO9hNbWF6BWxDk5sduE7KbTIvyw72oDDMYRlwnBr/dLfwSEUA7sI4WgaNyhSkGfNMCHy8XC+9LcS/oa9fVsljHWQxEiYJTzzpCcE9RxLhCdMf9IfW0xKWvA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKFJxZ2+kCIPS11EhpwNvCR59jz94fC2Zn1gD1Ogz8I=;
 b=eGkemGGqA4ziRNcBHlW3YoF8/bc8AQo8s45SQXbmSM5VYEh1MsGTASz3Etaqj5A75UCxBS6y6I8hxAekXXXrHLx8tW41dUCHzhRwcTd5lRiUWpmzs0lParmZGe6p+FuTCSmsehhjoY7rWvHyYjXITxMPb84XDDuTk99KD4wwrz4=
Received: from DUZPR01CA0123.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::8) by AS2PR08MB8998.eurprd08.prod.outlook.com
 (2603:10a6:20b:5fa::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 16:30:28 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::79) by DUZPR01CA0123.outlook.office365.com
 (2603:10a6:10:4bc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 16:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 16:30:28 +0000
Received: ("Tessian outbound 31df1b57f90c:v228"); Mon, 05 Feb 2024 16:30:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3413c311706102e9
X-CR-MTA-TID: 64aa7808
Received: from a84e53a11534.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id E4E84FE5-8F84-428C-ACB9-145F11205B65.1;
	Mon, 05 Feb 2024 16:30:21 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a84e53a11534.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 05 Feb 2024 16:30:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpFqAKwzxcQm2w7zqIWAFyG836slqrHazQhe9fflhFDWGFrIzILnCg+mdV4EFwAX/j/cf5OGXOc3f3uSgmSBQk2BpbNS5JQ1PnQtQaZRAIkXoj1gxhxefkv4OoR8i4tZ/GLrXGHC/xbE56CNAxcri4TwFMVnTGudDhiN/HkgwP4OQKzwthiRCmcViQyxTayZ1sL+PtwyTG2Z9ZO7/zfUm3od0kyl4l6kpWNptJzX8rJq6Smn5UUZN0Wfv/+MQx+Bkde8KQhJ7OdJqBfIUVjpFpWl84JS38iajgj8cPao8NyhcyXCUCUY0l9vDMXqk+kKewdhPkP758OJ820EuQXYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKFJxZ2+kCIPS11EhpwNvCR59jz94fC2Zn1gD1Ogz8I=;
 b=QeWjlujpd79364d5x0pKDQS1BtAGV/B58aS5yUid7oVWXitGW4+pEmFU4Lb3h5FT4JWixdhX9c6wivP1yqlsA6wwR2U3zm4Q/hLHmtVMShDYKHyymW5Md4kqvYmRcc2sB+dvnfG1gjlK0Q/pdeqWk2UAUBWD4Vanp1zMz4mKab7tX6rowLIXT1PeMZ4FOglIDYq7U0drrxYUIOihlgLFVu2G4Y3RHlE8XCwApsIkjdoO+kFDw6l5+DGqJbgoKlCh4RZ/GJAVpWxodHg7uyFTToMKwHqXNvo8J4pwoRTXCDFSZvZiiQGZh/egbvuG70XOYrdKfDfjYs79myxRRm6X/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKFJxZ2+kCIPS11EhpwNvCR59jz94fC2Zn1gD1Ogz8I=;
 b=eGkemGGqA4ziRNcBHlW3YoF8/bc8AQo8s45SQXbmSM5VYEh1MsGTASz3Etaqj5A75UCxBS6y6I8hxAekXXXrHLx8tW41dUCHzhRwcTd5lRiUWpmzs0lParmZGe6p+FuTCSmsehhjoY7rWvHyYjXITxMPb84XDDuTk99KD4wwrz4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU0PR08MB8640.eurprd08.prod.outlook.com (2603:10a6:10:400::17)
 by DB9PR08MB7493.eurprd08.prod.outlook.com (2603:10a6:10:36e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 16:30:19 +0000
Received: from DU0PR08MB8640.eurprd08.prod.outlook.com
 ([fe80::5334:4a53:f0af:e0b1]) by DU0PR08MB8640.eurprd08.prod.outlook.com
 ([fe80::5334:4a53:f0af:e0b1%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 16:30:19 +0000
Date: Mon, 5 Feb 2024 16:30:17 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Evgenii Stepanov <eugenis@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, kcc@google.com,
	hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 22/35] arm64: mte: Enable tag storage if CMA areas
 have been activated
Message-ID: <ZcEM+DjRX/UB07yM@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-23-alexandru.elisei@arm.com>
 <CAFKCwrhNE5PR7cu7tN8qMmSEUhdJ7ensGGrB-oodh-J_fdoRcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFKCwrhNE5PR7cu7tN8qMmSEUhdJ7ensGGrB-oodh-J_fdoRcw@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0403.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::31) To DU0PR08MB8640.eurprd08.prod.outlook.com
 (2603:10a6:10:400::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DU0PR08MB8640:EE_|DB9PR08MB7493:EE_|DU2PEPF00028CFE:EE_|AS2PR08MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: df412087-8631-4701-9232-08dc2667c39e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 bApf9F3aiu2d6QZbYeaETDt+MGR/RiKKAQJkg06AakVjvgklUUjf4E0+39BREKJljiL685FU4Lqmt+nLTkV60Gs0Qq8Bt25+t9B5Hmbn/XCUzd4nIBGwNbvKbHhooREIAyhz+ya/ihncZmOhIf98SS9eFjF5ecSWqwegmXhA4e6pBT4sIu8lncfVy2z6o65VAu/mO8qtNbJwoy6KoNi+AuM4S0d6HD/OscQCuIFg9B/ICGBSaN7sZbKqMMgXRoHWz64s+yREUpd3PP4xG5MrepADSbEFMqLv6bdbb9IpJk4OMX3qlHr7O5WKfCfuBAvE/vWxNBOb0NBnhIBLyMU9xrpk4Z3//ZIJ+T6F3BPQLZ/Xixf6iOKKA603XbzYkMBKs13W3KrUiE8vJEAsWcc8MLeR+NQIq/N4x1ekesI7RYX2weEJ/qGSH5YMafUUNWlsxOzM+VS17itIVeC4YsKdtD9RYmCzXo7N+i3ze5dkxdnwkRrW/V+bjckz7AYwkQ+759Nv70Fv00P/krwXwWzwQARFhYPyDN1HvQWKzk0elOGjbLYQI/0OmGFU5yUHRX55
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8640.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(26005)(44832011)(66476007)(7416002)(6916009)(5660300002)(66946007)(86362001)(66556008)(316002)(2906002)(7406005)(38100700002)(478600001)(6512007)(53546011)(2616005)(6506007)(41300700001)(8676002)(4326008)(6486002)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7493
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8196798e-9e5a-4316-65a9-08dc2667be34
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OK6CINt7S881L2NxiLvKc8x+TLkgnGs8kanKhpRoHuOSNYVhM0NsnAzSrL0FoaZxWzwNjhJ/Vn9GbFg9YDOW0g7UK5hwyDFxWcNhzavvIi3l4DTKWHP4M5eyxOjfRm2MyWbIg2Z7J0/mabdneYLIzNcyHavY+rH3SKBo3JcwgvkFkqSAPjFT3okH+G6pB61W1r29Xkm6y/YeEKYKR3XP/HAb3e4iuakGwfsI/zeThsRzTQQ7P9XtK106QC21GKSJXryXz1Ps3hBYSOBj8qKOj9xNpTWaGprYaU2kBZmGxKNq8+8sQDs8DMbT1EdTpvnkW7rZrgL6Q+DR8ZizVmA9Z5PeB4Rnztu/UDmIW4HkQ4ktGBF/T79BB2T0VHpLM8rqWIfC5unLbURieL2KM5PPnwpKF9+OFotl38Aljp7CRfzj5aZV4hvllEXh/Yu01jWzUiZnxAvztiL3R6QHxs0FtiWrNHZpP1zbg8ihNkQP4SnMT6shN4Gh2elTH4AU06pQ+du2MuRaUwKZ5F1PG6eQWSnZezHrI3uuNIfWZwixPYiD4a+wgEGc4mfADwEQmA5KFAeJgfIKiKYlJa1eyvbzvuaqKut2cdLToJjIPxQDAQCtVQSzxJvfP9wRgJzeijC6Au6d/dUOvtCK+cqkbtB5fc6cTKQUBAdAajkIh5Y1q6ndc25J4YVf+WYz0d/sLs6Qd5V1L3V5VLNpP5gbicRJS0QKE8W1b5+Fr3t3MQeVN+GWILy61Qi9Yz9lpcRrVPpX
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230273577357003)(230922051799003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(41300700001)(47076005)(36860700001)(83380400001)(6506007)(53546011)(336012)(26005)(2906002)(356005)(82740400003)(81166007)(6512007)(2616005)(36756003)(70586007)(316002)(70206006)(44832011)(478600001)(6486002)(86362001)(4326008)(6862004)(8936002)(450100002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 16:30:28.4891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df412087-8631-4701-9232-08dc2667c39e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8998

Hi Evgenii,

On Fri, Feb 02, 2024 at 02:30:00PM -0800, Evgenii Stepanov wrote:
> On Thu, Jan 25, 2024 at 8:44 AM Alexandru Elisei
> <alexandru.elisei@arm.com> wrote:
> >
> > Before enabling MTE tag storage management, make sure that the CMA areas
> > have been successfully activated. If a CMA area fails activation, the pages
> > are kept as reserved. Reserved pages are never used by the page allocator.
> >
> > If this happens, the kernel would have to manage tag storage only for some
> > of the memory, but not for all memory, and that would make the code
> > unreasonably complicated.
> >
> > Choose to disable tag storage management altogether if a CMA area fails to
> > be activated.
> >
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >
> > Changes since v2:
> >
> > * New patch.
> >
> >  arch/arm64/include/asm/mte_tag_storage.h | 12 ++++++
> >  arch/arm64/kernel/mte_tag_storage.c      | 50 ++++++++++++++++++++++++
> >  2 files changed, 62 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
> > index 3c2cd29e053e..7b3f6bff8e6f 100644
> > --- a/arch/arm64/include/asm/mte_tag_storage.h
> > +++ b/arch/arm64/include/asm/mte_tag_storage.h
> > @@ -6,8 +6,20 @@
> >  #define __ASM_MTE_TAG_STORAGE_H
> >
> >  #ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> > +
> > +DECLARE_STATIC_KEY_FALSE(tag_storage_enabled_key);
> > +
> > +static inline bool tag_storage_enabled(void)
> > +{
> > +       return static_branch_likely(&tag_storage_enabled_key);
> > +}
> > +
> >  void mte_init_tag_storage(void);
> >  #else
> > +static inline bool tag_storage_enabled(void)
> > +{
> > +       return false;
> > +}
> >  static inline void mte_init_tag_storage(void)
> >  {
> >  }
> > diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> > index 9a1a8a45171e..d58c68b4a849 100644
> > --- a/arch/arm64/kernel/mte_tag_storage.c
> > +++ b/arch/arm64/kernel/mte_tag_storage.c
> > @@ -19,6 +19,8 @@
> >
> >  #include <asm/mte_tag_storage.h>
> >
> > +__ro_after_init DEFINE_STATIC_KEY_FALSE(tag_storage_enabled_key);
> > +
> >  struct tag_region {
> >         struct range mem_range; /* Memory associated with the tag storage, in PFNs. */
> >         struct range tag_range; /* Tag storage memory, in PFNs. */
> > @@ -314,3 +316,51 @@ void __init mte_init_tag_storage(void)
> >         num_tag_regions = 0;
> >         pr_info("MTE tag storage region management disabled");
> >  }
> > +
> > +static int __init mte_enable_tag_storage(void)
> > +{
> > +       struct range *tag_range;
> > +       struct cma *cma;
> > +       int i, ret;
> > +
> > +       if (num_tag_regions == 0)
> > +               return 0;
> > +
> > +       for (i = 0; i < num_tag_regions; i++) {
> > +               tag_range = &tag_regions[i].tag_range;
> > +               cma = tag_regions[i].cma;
> > +               /*
> > +                * CMA will keep the pages as reserved when the region fails
> > +                * activation.
> > +                */
> > +               if (PageReserved(pfn_to_page(tag_range->start)))
> > +                       goto out_disabled;
> > +       }
> > +
> > +       static_branch_enable(&tag_storage_enabled_key);
> > +       pr_info("MTE tag storage region management enabled");
> > +
> > +       return 0;
> > +
> > +out_disabled:
> > +       for (i = 0; i < num_tag_regions; i++) {
> > +               tag_range = &tag_regions[i].tag_range;
> > +               cma = tag_regions[i].cma;
> > +
> > +               if (PageReserved(pfn_to_page(tag_range->start)))
> > +                       continue;
> > +
> > +               /* Try really hard to reserve the tag storage. */
> > +               ret = cma_alloc(cma, range_len(tag_range), 8, true);
> > +               /*
> > +                * Tag storage is still in use for data, memory and/or tag
> > +                * corruption will ensue.
> > +                */
> > +               WARN_ON_ONCE(ret);
> 
> cma_alloc returns (page *), so this condition needs to be inverted,
> and the type of `ret` changed.
> Not sure how it slipped through, this is a compile error with clang.

Checked just now, it's a warning with gcc, I must have missed it. Will fix.

Thanks,
Alex

> 
> > +       }
> > +       num_tag_regions = 0;
> > +       pr_info("MTE tag storage region management disabled");
> > +
> > +       return -EINVAL;
> > +}
> > +arch_initcall(mte_enable_tag_storage);
> > --
> > 2.43.0
> >

