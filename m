Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B77F6D71F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 03:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjDEB3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 21:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbjDEB3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 21:29:34 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 18:29:32 PDT
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA7530EB
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 18:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1680658173; x=1712194173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bWHRrBIhcrBhEzQVrooeixlLMLzU+hbFStxYATrVBA4=;
  b=l9K6ytHbXW6hR+a9FV+VG6ocaCjMo79bcU1o96irTGUqoOM2BOKX/Q9U
   8ep3cjUYNRIYXAIQebgXmgSQgPYU0lHEnAT8D2Fu87+Kk6V0Peb2qBTny
   R4HkgOn5mXVKS7WsaY01bjzLn772hvQ/Yir+9RDqPpxBK3LFRwtUWz6tk
   6dgxBdtQO2QL6BV1UZoKUBSbleTN6Gt2mLNm9fOw5fr4XU5p1mA37xhQA
   MzCcPc/xSQ9ysGEbqLuMUZ86RlvywQPa1ocsa0HBo6DDE1csaEBHNjEEg
   YjV+tTO9VpRzhLRTr/l8DkAJ0/+PbaIcTDDSQMP4cDlzIqCtXWfINbvSx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="81003338"
X-IronPort-AV: E=Sophos;i="5.98,319,1673881200"; 
   d="scan'208";a="81003338"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 10:28:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8JJwWfhZ5latX1x9LOJQ5DnXDO8bbT2j9GNows7FmWcL2980STpDTpsVnUfoIUx5/biGv7o/sZIfIO7y7Kg5RC0lB5tOl36nTPCS9QD0+t4ZuCN+PGJusjdUSz7slkCANIAq5kMcx+OQRlkHBFD2HsC5qYg1GpWjAS0GTBekFcOWO8MnNMzSDWWUI5SWkrSBfrSBvXA/GTSsvcfti+QhO4PbH4xkZCUhwxQvSui2ER+LBDkYEHWHGMcV1aY4XNi/n5FbPvnb+9GitBU7QvRqDfp0SrnTV1I//dIO2yKQln5nfqqDbKrZokNEL4cMrYgOjGQozQyGo0UJafbnQrTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWHRrBIhcrBhEzQVrooeixlLMLzU+hbFStxYATrVBA4=;
 b=X+o3O0aGtIHbXWOXA8syeUWTWJxbmfl2KAjpfArkwwXmsMJCuk2DRotoR1CPOq34cfWkPWC5e8pvvuFEzCa009TeJR0w83y49WEw9pRGl7W0E14naZhpD+uIdJVmQQJ7zZEgZ6HjsJejmDECwdegyfqqj/yp7xLUTPU8t+cPL4u0TNsVgUayYd4q+4lqLwe3eDob8VsOySH84J1g0A5YsVeXaCqfY7Cy4FZd8oOF2MfX1h/u0y05sXuxarjSt2KAA27kGsCVpkMZODTRZxHqy25nYH/1X/dl2mA3idQ4Zs4UAQQs/j99O+GHYjTvdoHAp9Z8T8kjqfXR3nGGE5D+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8)
 by TYWPR01MB8805.jpnprd01.prod.outlook.com (2603:1096:400:16b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.36; Wed, 5 Apr
 2023 01:28:21 +0000
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524]) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524%9]) with mapi id 15.20.6254.034; Wed, 5 Apr 2023
 01:28:21 +0000
From:   "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To:     "'Darrick J. Wong'" <djwong@kernel.org>,
        "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v11 2/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Thread-Topic: [PATCH v11 2/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for
 unbind
Thread-Index: AQHZYVmjCIYa7VVsAkKtevkkUtDAo68bd7yAgAB8c2A=
Date:   Wed, 5 Apr 2023 01:28:21 +0000
Message-ID: <TYWPR01MB10082AAC981E7D46D41426FE290909@TYWPR01MB10082.jpnprd01.prod.outlook.com>
References: <1679996506-2-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1679996506-2-3-git-send-email-ruansy.fnst@fujitsu.com>
 <20230404174517.GF109974@frogsfrogsfrogs>
In-Reply-To: <20230404174517.GF109974@frogsfrogsfrogs>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 2c582085817d42d4a1f369df51a98e22
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDQtMDVUMDE6MTA6?=
 =?utf-8?B?NDNaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD00NWYyNTM4Mi0yOTUzLTRiODkt?=
 =?utf-8?B?OTQ1MS03NjcwNTQ1ODlmOTY7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10082:EE_|TYWPR01MB8805:EE_
x-ms-office365-filtering-correlation-id: ccefe4d7-3dd1-4e49-7921-08db35750ae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6q0HYxCse2Su0CxiAO9hfILX3rsExrDqAN6fUrcTL6OFFE/5+GNde7UUafMasnItcDkYi7iAw2/KRkSR0fRFFRHVCsLLSFC5C5ZsB/n1v4828zpQ1IXzv7G/TLGc9YcGOGm/lTG/ku5vGPP/qUWNuO4xK4lTpNhgvpg53oSHV+mjpQ4LY9DbFTDDOKWrXbMb+jaQK6I5mIcz7QznX6pWw5dWLp1K9abrCcmUm5S32MzYhO1JI9ApGqoJMJE3d645MRGfiZzN/+6sv9gCGu08f0/BhqozsL+eBTd2jm1PxKVVk7utNwqeXvb+W8cuwjHIPCn23yKR6t3C+qe4aK/0151gl/gVHep/6HQQ3tkoi2ugmWY6dOxKDoFKVJCKjOK9qyUJ9Cy6OQDlmeAX7Xb/HqW1HpRNwv0fTvjTixGMnNHjx6j9GZv5/igZPe265HSFRQevBCdSFjzheUgiTls8r2rGemul7krbcdSf4XB/GhqQQHVq+Pp6sPHRurSdcUjDSiU88BQ0gEANTzminzd4P5uWRhL07RlfzwCfpW8o3Fh1AmzLRG+ZXU0xEnyMggWW6fyyUj0gxA0WKsKvWGlbPOSyihvdgTZ5Bgc4gfGeyM7J1bpTxOZmHQBiA7P+kI7cHuSPfFtQcUtoVLDtVs7Cww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10082.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(1590799018)(451199021)(76116006)(7696005)(478600001)(26005)(6506007)(9686003)(54906003)(6636002)(55016003)(71200400001)(66556008)(66476007)(66446008)(64756008)(66946007)(4326008)(966005)(41300700001)(110136005)(186003)(316002)(1580799015)(5660300002)(8936002)(52536014)(8676002)(2906002)(82960400001)(4744005)(122000001)(33656002)(86362001)(85182001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkxtTDBmV1krY3BybHZKSDdGTHJsOVlYQm9YVU5tNFVNQXY2MlVvVDZtb0Y2?=
 =?utf-8?B?eGJDZVZPZmhlbnh1Q1h1SVBuSk1SYjRIKzFmak9nWVhLbEFuK3dGblZYMmEz?=
 =?utf-8?B?eVpOdTZWYXUwcmZkWHNERWI1NGlhTG4reXRIalBUS1hidmhrSWpZOEZqdCtI?=
 =?utf-8?B?ZlhOQjNBbmxUT0xBRWFsQU1qdStlU2pjV0hrNzNQYlJ1cThzWTQ4VGVjTm4v?=
 =?utf-8?B?OE5nTmsrWS9oRmxBY0pBamd1ZEpvVFNRUmtUZW5SOXpXYy92VUJLRTlHNEZ1?=
 =?utf-8?B?Tnl2Zm9HY1Y4T0xPNFpCMjExb1h1TktMbyt2TzNGWlEvckVwTXljekRwNFgx?=
 =?utf-8?B?YUlrc2t4ck9YVzdwTnRrZUJKRzNnQjc0UXVuQ2U4eVc2ZVJmaE5KN1g3Wi94?=
 =?utf-8?B?cTljOERBUjYrYlQyOXAvckwxY0wrWTFCZmhXNTU4N3BZZDd4VXhoYjIxeSs0?=
 =?utf-8?B?OWlZOTFzRHRKWEJzMW1IM3hrUEVMRFV4OW1QWmpZZ1JiQTYyZnU2RTg5TlBQ?=
 =?utf-8?B?WEZFZU1GRVoyWDY5eDgvYTVMZnh3ODhKWnNhUk5HRHpmV2hDMXhaSXZQdGxQ?=
 =?utf-8?B?bHJiZHptZ0xpL3NOMjZ3SnZ5bHpzQXVjelJzc3lIN284QjZ5WFc0aTBBZ1JO?=
 =?utf-8?B?a3pwTjRaNGprSTdqam5wWDAyNWV2UTYwMmdUN1phVmpKSXVpSTYxQm55NHNF?=
 =?utf-8?B?NmlLMGtremRoY0ZjcFBmR3ZEODk4V1dLUWtOMEpoN2xRanVva1oyRWRVdFdB?=
 =?utf-8?B?QjNuTjJVdEZEOThuaU5nUHVNVVF5aTN5MDRwRmZpTmhHMXJSSGZQMUg5VU83?=
 =?utf-8?B?MW0vYjk5d3c1cFhEdDFCR1VJZFhhbW5CVGZic1lRR3ByTTdVR0E1eEhrQjBz?=
 =?utf-8?B?T3M2KzJSY1QvelBoZ2JOMS95OGtCbllIakpTTUpLeHl1YUsvOERoc0JQS2dC?=
 =?utf-8?B?YWJITkVtaElpQWdFSDhoVXM1ekttYVVlRktZeGhFZUNvUEYxeEhBUzFqRlJp?=
 =?utf-8?B?UDdpbWxib2Jua1E5b09WcW1tc0ZDWUVWNFFMNkh3bFQ2NnhqbzdaMDNSLzNz?=
 =?utf-8?B?Nzk3TytZZUM2M3RJSUdXa002NmFIVWJXVTNmYVZEd0RVYmV4VVdDMHdXdmtt?=
 =?utf-8?B?NEtqWlNmSXc3TWFrVUw3UzBnOEdXN3lOdHdWc0I4TjJVQm4zcG5ObnRxcjkv?=
 =?utf-8?B?Yy81Q1RIOE9reWVtVkt4SlM4dFQ0Sk5lb1QvMWxaYXAwL015ZjhEM0pDckVF?=
 =?utf-8?B?U1V3c20rRFdTTTFGSGpud2tORjkwY0ZCaVRSeVFBcUJuS2F0TGdRY3FHQy9Z?=
 =?utf-8?B?UTFmZU5QRFRKQUJuS3hCd2dpU3lBVjlKektUVUg1aDhFQVNibGZOdXN5eGhI?=
 =?utf-8?B?ZEpuTm1Icnd2SnhhZ0x2ZUFEZEJhYm5OS0M3R21YYlB0MUlhbU90WDRuejVQ?=
 =?utf-8?B?d3Z3K2RMU2c5QnkwUExLeHRzUitQREZIcGtQTXVEOVBsOW85VUtWY0NPY1N1?=
 =?utf-8?B?MTRmYVFMTmNCaHFYam15a1lXNDhqeXlwN0lqNTNHZTRlSnRwWEpYYXlVUGx4?=
 =?utf-8?B?V1NJM3kybzdnbTViNHZod0ZmY2VnOHlaQXhDTVBOb2YvTU9yY3A4QUVkNnFs?=
 =?utf-8?B?MEhVWHlUQUZKUWlUWUkxT00rdGJiK0JnUFl0M3lHTDFVUWEyR2dWUENFWkxz?=
 =?utf-8?B?VmdaN0EzenZtNHBNTk8vVkVjOFZ5dUlHaTlYQndub1Y0Sytad21FK25KWVNU?=
 =?utf-8?B?ejFLUERYT3ZtSm1nNlVjU2NPMFFYMWtTVG9JRllISk1XQ3hZZTdrb1lkbnY4?=
 =?utf-8?B?cTJ5RG5lN1Bwc1JIV2R5ZnpSajhjYit2ejd1Y29xZVBSTk5VQlIvWjVQR204?=
 =?utf-8?B?QWF5VFVCQXZPem1wZndZQlRudWxmL3FTb3N1YlVHNVVjNTAzOEdpZmNPM0hF?=
 =?utf-8?B?cnpXZ0NyT1FveFo5NUl5QmZ5WTR4S1NhcVVtTVZ2WGdtdVhBRCt6RnNYbyts?=
 =?utf-8?B?eTdYWlErYnMyT2YyejkzOUYrQ3VzQ0Q0V2hHMW1MUW96dGE4ZGxXN1RhMTJv?=
 =?utf-8?B?SnA1eEovNlhxclZ5TDcvOWtuN01VZlVTOVZJM1NpS3UzWC8yVWhESXdZWWc4?=
 =?utf-8?Q?MaL7REHTIUTBKZTbRz5G7ERoF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NE9ORW0ybUtDdlM4KzZlOE1oQ0VwMTNyOWdGMG5BRmpmYnJGWGw0NlhORFZG?=
 =?utf-8?B?dVRBNm9uVk9HTDVZN1crUVVheXVTWWdPc3NhVTlYNnhTa1JsV1lrQy9qV1FQ?=
 =?utf-8?B?QktBa1F0R3NFYXVkWVVEc1M1c3BVSGFVOStMRXN2aGxSWFdsRWhVNVF6aFdF?=
 =?utf-8?B?eityVHJRQWVQS1pybVdHQjhWcytGL2h5bU9CQ0NvTWJmbDVEb1FMZ2VpWUQw?=
 =?utf-8?B?TkdveDBQbURBcWpNQmNtVVlndTREK0t6MVVQbjFCQXFEaklWdUZrdkVqYUtB?=
 =?utf-8?B?dUNqVVR0dUVIQ2cxVGdZdUhWWVFPOE1WZWF5NUxqRWRKODdkS3A3OXFlamFK?=
 =?utf-8?B?WWxDV2plVWsxem4rQVhTMEhRblV2V1FBN0cvQnlxU0VEc2V0aGZMM2FVaXR5?=
 =?utf-8?B?Ulhkd0lQVHRrWXVxdEExeXpHaFhLWSs1c1N1WllSWnBGOWxGb3ZOSkJ3Ukh5?=
 =?utf-8?B?b3lCWFBqQk9XTVJJMFdYTlpKdGRDb3F0ckV1Y0U5NmRGQXBmSHVOVnNEQ2pj?=
 =?utf-8?B?SjNhV3k1ZnZFck1wRWFFUFV5TzZoU05VbHZ3dVZTazU2cHRKcVc0aXRxdXc3?=
 =?utf-8?B?dWtPTXkycGc0RFN6M2lFV0NFNGNPWGtRc2M1N0h3T3QxeHNpU1ljTnhoajhR?=
 =?utf-8?B?UUliUGpWN0ZiOVp3cnBYSXRCc1haOWRESkIvUHd2MzRRbG1ySzZOdlRoaGpY?=
 =?utf-8?B?cnhRazJFbnNtN0tOeG9LQmpFUjZQRVo1K2lpOUI0MXV6b0Zma0R0TGFabVVW?=
 =?utf-8?B?M3BCU0FESkJvbTF1dXF3TjZ2YTM1OFlVVVAzTFllQmJIbWZMUGNRQnhIcUlL?=
 =?utf-8?B?d2N4UnRPNHk4L1doaUNWSlpkRVNVbGZSMFBMQ1JkNmFjdHZqWm5tRFZJbk5L?=
 =?utf-8?B?b0xiWWtzd0VYR0xDaDNQVEQ1YjM5eXZkank5M2paM09PSWVnWDFwQ24xb3NY?=
 =?utf-8?B?RGh3eFltTktlb0x4Y21xU2I1SVVHNElKaGo2bG5EN0IveG9UQ05uL2xhQi9n?=
 =?utf-8?B?ZWZjK1hsOC82bE5qbzR3NThYWHloYSt3N3RYUjQ4N0lNdyt0U0xWQ2s5T0FD?=
 =?utf-8?B?OUp3OEhTQlY0SEd4dzFhUGt0RnltYUxaQzNtL1k0eE5sR0NqQlBmenNaeVVw?=
 =?utf-8?B?VzRsVjY1SzZFcm1KNGdvOWduUmpZYkU0d1poLzlIZi85M3dMcVJYRVpubEZV?=
 =?utf-8?B?aG5QTnA3dEhUclFCRmhGREZ0RHhNSWMzQ3N2ZkNqUjh1NVlzUlMxVVFrVFB5?=
 =?utf-8?B?dkYrM2o3djFnVmlDU0tkeCtaaEVBVlpWN3BldVE2TWpWaDRSc2p2NEJjYUEw?=
 =?utf-8?Q?hseQQQhBfdjJNhg5+gQ5d+USD9LltgipWY?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10082.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccefe4d7-3dd1-4e49-7921-08db35750ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 01:28:21.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cv6QSlHddWKvoSnEkQEEiH2nUB5Gy/3c/e/gHMZCSyrFyDYKOCiHHZdTC2eSd+Gq18stThajME2divY9z9Plng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8805
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGVsbG8sIERhcnJpY2stc2FuLA0KDQo+IEFsc286IElzIEZ1aml0c3Ugc3RpbGwgcHVyc3Vpbmcg
cG1lbSBwcm9kdWN0cz8gIEV2ZW4gdGhvdWdoIE9wdGFuZSBpcyBkZWFkPw0KPiBJJ20gbm8gbG9u
Z2VyIHN1cmUgb2Ygd2hhdCB0aGUgcm9hZG1hcCBpcyBmb3IgYWxsIHRoaXMgZnNkYXggY29kZSBh
bmQgd2hhdG5vdC4NCg0KSSBuZWVkIHRvIHRhbGsgYWJvdXQgaXQuDQoNClRob3VnaCBPcHRhbmUg
aXMgY2VydGFpbmx5IGRlYWQsICJwZXJzaXN0ZW50IG1lbW9yeSIgaXMgbm90IGRlYWQuDQpCZWNh
dXNlIENYTCBzcGVjaWZpY2F0aW9uIHN1cHBvcnRzIHBlcnNpc3RlbnQgbWVtb3J5IGFuZCBGUy1E
QVgNCnNob3VsZCBiZSBzdXBwb3J0ZWQgZm9yIGl0Lg0KDQpBY3R1YWxseSwgb25lIG9mIG91ciBj
dXN0b21lciB0cmllZCB0byB1c2UgUGVyc2lzdGVudCBtZW1vcnkgZm9yIE15U1FMKCopLA0KYW5k
IEkgaGVhcmQgdGhhdCB0aGV5IHN0aWxsIGV4cGVjdHMgQ1hMIFBtZW0uDQoNCigqKSBodHRwczov
L3d3dy5kb2Nzd2VsbC5jb20vcy95ZG5qcC9LODZHWTUtMjAyMi0wMy0wNy0xNDUyMzMjcDENCg0K
U28sIHBsZWFzZSBjb250aW51ZS4NCg0KVGhhbmtzLA0KDQoNCg==
