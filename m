Return-Path: <linux-fsdevel+bounces-17503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297B48AE5F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32DF281ACE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 12:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2EF84FC5;
	Tue, 23 Apr 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XsGhA3PI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="STfS8lim"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876278285;
	Tue, 23 Apr 2024 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875150; cv=fail; b=L9iCNqr7ceFzev5hKifZL+HxCnhOx3eFcynBve4XVw4r+2VR9wcjvXCEH4+GzF3amBO5iArFHsvDd3JD3edcQWaOPLvNoGnRMqseVnN3W56mcXCh4GXRT5iyxFQA3V8klLBEoBCiB3prz1BOHSbLSrz1M/Gy0xpBHxPfIObji/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875150; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XeHG/u7zomkUEnaCjypKa3rcCvdFfaiPm+fK7m+qO7Mj8MhNIE/REu8JSkcSEuDurvia2As9Lp56jVkfBBAkIGMHV2aVl1X7UDaW+4jOUhnL3MWt36lokJ+CvO29qRTWEiSHFzVaQhdqIVVhAKAbTPhp4f2YKeVkRA2GkEXwPXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XsGhA3PI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=STfS8lim; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713875148; x=1745411148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=XsGhA3PIXdcezCPBH6KJYRFLIPeooK1lgf4YQ6TCtdOm2eJXO0yJTNyb
   NTT+3OTsNIqWHPOC35qb03QOOm5IWmq3I2bGxsIpTjeKUSZtDGeW8H5pj
   DnrlnZTuRe7lVlb/7b9zfWMl/ExNNB0hCRwTRw9z70XtgDcGZxSLLT9RM
   yUr+/RcarQsGtFJwIzTJRWiBet7Qz0R5Egb+wZi00QpVL85FyvSy3SESe
   2qno2PI9mPx+YidlQEg3SUYRx1Xk9TpeEnsW4/MtXLs+baw1Ct+d97pu0
   qh1+mw8chNdqnqHQJ0h5CJOxx/Cj9EwD+xa4POtbgPKyfprjIy8G/Cxmf
   Q==;
X-CSE-ConnectionGUID: ckYFV+T3SkagtL60LQMwag==
X-CSE-MsgGUID: MoUnqwgSTeK3jdzH9qz2FQ==
X-IronPort-AV: E=Sophos;i="6.07,222,1708358400"; 
   d="scan'208";a="14655047"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2024 20:25:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXV/RCM91A6laGNWxrSP8iHbuMdnvZ6WrVYMgp9SPwIZiIyv00FvwTnubBaX5xw4pJ2oysl73p4RRmiVHD0hzNePiVEL30VzYkjhGR47QB7B8t2biN/riIg2YdueSc9j2iTR7OBshWIWDwgz2tX49RUuC+Kni9kXZbas8v/pBI8r6q2lOLRuXPjN/sbK+ELGrBLGy21pjL7ps++KmUujknevL+rm21zNRUaLwP0lrTe95OEKOt/cUiqqdjESTg5ciTv/EGVyugriMVsJ53tsiyNgmWNw2iEsWMPFOWQ2xMbLnIskw/UYky0TUtr1S1dNnrhI4il8pSo1saKfn14Dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=I6rTUXfgAdzXQYb5AAwMb5T46Zjc98PhOONUNqHoz2+W5aA9ErffZIGDAZNRx/j/8U53oXJJeQH1vScArIvtiR+fB20voWUkZbCOd+TtBGlj2SCco2jHlCct52g3xvdVB5whT4xyhdYaTG/PbtG9Q/+/YywZOhuaIv4CaTxrG9L738wPOzbfi0CEcOzNB/MvWbDGQNVKi2DIP8NeJuF7hE7qERkYuPaTxPVnOPyRts76wWApJa4Zcjz1PABnVDDqiV6DycWYzBzFmgB3kSbi6JB+UP6pbdCvdOTpyjlvHmuuFDx05jUOYChHz2GcrsSm3vwO/tPGNj5pJ+pVt7YLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=STfS8limCmv7/I0KEBRba3LDYcNpM1sw9ZrT/uvGOV5S+reKsr45ObArBm+SOvREBxIxew5HaUszt8AUhLigoUCMyQfgU4d1XLBmRcqsTjXWMglHWktMyp+wKCQZh4OrHKRH96MU3lF+nn3R8W164yEhcy21bUUt4pwEni+3iJw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6983.namprd04.prod.outlook.com (2603:10b6:610:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 12:25:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 12:25:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/30] btrfs: Use a folio in wait_dev_supers()
Thread-Topic: [PATCH 01/30] btrfs: Use a folio in wait_dev_supers()
Thread-Index: AQHaks2WZpb15UplL0+Fyg+iEyKw+rF1zRWA
Date: Tue, 23 Apr 2024 12:25:37 +0000
Message-ID: <4c136347-1aa2-44ba-9f63-229880d69c1c@wdc.com>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-2-willy@infradead.org>
In-Reply-To: <20240420025029.2166544-2-willy@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6983:EE_
x-ms-office365-filtering-correlation-id: cb8c6507-95a7-4fb0-eda4-08dc63907b38
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2xqMFUwL3pUYTFDMVJrYkNHa2Q5ZHlnZmxsalp4OTUzUjBZaGxtMWtYMy9a?=
 =?utf-8?B?NkRXR2RUcmFjWm42UmZnMWNTdktPZGlMKy8rVzRqQWFKaGh0MXpSSjFwSnJu?=
 =?utf-8?B?amYzbFVZb1lvM0VDOVFCTWFGejc5d01MNkROZEVjd0p3M0FDMTdNdFUxcE0v?=
 =?utf-8?B?dk90RE1jZkt4MGx0aVo4V01OdVQ3K1NTN0JzeGwrcHFMbitwVlRJTEh5ejda?=
 =?utf-8?B?M1YrUVBQK2grbXR0bTNKSExOZERPa0ZLL0JZOHBmVzlZV285RjN0T2oxZXdS?=
 =?utf-8?B?NzVDRy9QMUxGZ0MvcGZPWitvZGl5dGxjaDBkVzNlZDF6c2lkalNRRSttdUYz?=
 =?utf-8?B?V3A1TlFpaE1jcW4xNUdzL2FBK1Q5NXF6QXp6ZzcxMzZWOFpoSlZMaHAxOVlN?=
 =?utf-8?B?UUVLb25VUkxreUdidk1qMU5rTFBUTVIzeXdrTXU0bjBCZkdJSUllNzgwK0pN?=
 =?utf-8?B?RVp3VWs4azh6U1ppRE5obCtLRGwzbDh3end1aWZUTjhhT3U5M2ttL3ZkY05E?=
 =?utf-8?B?WVJudVFqSnNrWGwvQ3ErN3c0NFIrZTVSRWZMZjBlSDFTbk5aMFpRS3QvTDFX?=
 =?utf-8?B?dUVVRDFwalIzS1JBS1F1ejFFc2lGU3dya3BQMkxpdk9yUGRmNk1QYW4rcVJU?=
 =?utf-8?B?UVBmQldubmxkT3JIZ3BIeTJPS3JOc2lySUZna2dtZUJjQUZnamZHOXY3aENL?=
 =?utf-8?B?c1lnd2xiZFZVUEpveG5oMURKR3dyZklxUWpxUkRQVTBqYytGVFE3SHVnR3RF?=
 =?utf-8?B?Zk1WSExsVVdkMTRPY0tmNUFXZnMzZU1xZHRKaUs4QVV0akdNNEI5Q3lISXBL?=
 =?utf-8?B?djB4cno1SUtMWk1vc3cvdDRNbHFtWFZNeTNMNElHRGxCS0JqKytFZHg4MzFG?=
 =?utf-8?B?NFo2SXg2ZVgwMzNadzNpblhIdi9SWVd1Y0tpQUhscVVBdFN5RXR0WVlpVDZv?=
 =?utf-8?B?V0t0WkJTaUVmeTUzcS94Rms3eWg5VEZENFdMeHpSNVhIOXJOWHY1MzE2RTZq?=
 =?utf-8?B?cXkybTNuY1JWaEp5TFdWS0I1d3lZSElMSmJrY00zZ1Y5Rm1CWnNEN0ZBeDhO?=
 =?utf-8?B?TWFVT1dIdWJmNzhmVzVDeEg2bmFBR3lKRjFlWlVDSXpjWG5JcE94QXFidUpr?=
 =?utf-8?B?WXJLL2pseWVHQk5ZbGtFS1hFL2F0UjFvbVROSERwaXBkcW5lZ3FZbjJjVFJ2?=
 =?utf-8?B?RGhPbGZZMFpOZ0h4OWpHcC91VDZUWlhFSkJDVmZ5Zk4xSGtGUThtdlN3L2k3?=
 =?utf-8?B?blhvN2d1WEcrRnFOV0l5eVRjWFNNTHVFVEJRc0NJaUFPVzN6Y09SRzk1NUxP?=
 =?utf-8?B?RjhTMW11aUFkRDdna3ZSdXFGMnRxRUtlRWNJN1FCS1JjT2wvMTVOVnFqWTN1?=
 =?utf-8?B?Y2V2aHdJcDlOUklTYzZaTFl2SHRsOEdNcUdKY3laZlEvYXZXQ0pMUzE0bEJo?=
 =?utf-8?B?b1kzaDFIRUQ1UXhoUjJLalJFNWxWR3VYU1FIeEJzYjdZZjVEZWpwQ1c3SEVV?=
 =?utf-8?B?My9WZzc1Ym9hdWs4TU5uOStxOVVmdy9VQkdaUlh0YklSOFdoKzNtdjBSRmhy?=
 =?utf-8?B?Vmg2ci9ZbTdWS0VLZlhMVnoreUViSHF1d3NnN1Z2ZURIOHNVZ05lS3JudTFN?=
 =?utf-8?B?d0p2SnVHUmlMSEIxV3NqK2FqTjcrTWFIQVRDV0VCaDBrWjNHb2tMcjFhb1VK?=
 =?utf-8?B?RDFlUCsyMzM1M0xKb0xjaXdzMkRNNDhleHU0M2lTeUV2VWNmVDdVdHdNcWt5?=
 =?utf-8?B?UlVyN2ZXS0lqMFd1TkxKV0lMaHVvTXUxY2piUi9JUms1b1Z4VUk2QWtTNG5B?=
 =?utf-8?B?eGdvOHR3NEd2VVdtNmphQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXY4Z2c5b3hvelBxMGlGN3VnVGRDcitFYzBpZXl4eFRCRzFzOUNqY0pabDJ5?=
 =?utf-8?B?TmtDaTFDZzFjdXhWaUI2NklIRVk0Q0pHN0s2RjAzVmZhVW8zdDgxWWNaNkE5?=
 =?utf-8?B?NVNidmI1VitCQVFSQ290WlZ4MVJzWkhnQm5rM1RTdkhQSGdxYVFtcCtOR3cx?=
 =?utf-8?B?eWNQUEJLSlZwSVpLNER6UHprblpuOG9PU2VvSlBRUGhtWHRnRk5GdUxHTjFm?=
 =?utf-8?B?Qm01Wm5VajVHQnYxOEF6eVErN2M4RUkxV3V4WFcwSFZhSHRWa2I1eWhPNEhx?=
 =?utf-8?B?U3grR2oxQks1QVhkQklYZTYxc1lJdGhiWTJWWCt0dzhTZ3owQzJ3MWtlQnY0?=
 =?utf-8?B?NWJKbUtCNi95Q2xMRVhNUU5LTHI4QmZUL0E0NlQ5MzR3T3BJd2l6N0w1WWJT?=
 =?utf-8?B?anNUSVVBRWZZSjVHUnBOTDNud1VmODFZZjJJRWRkbjM2UFRRRFMzZmQrK1NE?=
 =?utf-8?B?cHhHRFVJekZvS1U1dzRFWjRYRjBRc0Y4OFd2OFVhc2FDeDNueEozOW9CV0lN?=
 =?utf-8?B?SXNheTJQeCthNk1zUUFsVXFlbGtXeTFZRWJzVm9hbGhhcEhqRml4M3ZZcmta?=
 =?utf-8?B?SDY0ZVFtNVd4cHdEZjlHclRiN0ZHbHNMZENLR3kwRkN0dEEzbVNwdnF2di9v?=
 =?utf-8?B?dkVvbyt0aWViTjdaV1E3UGo5WGtSRnFmWEJNRms5aWg3WVZKNThrSkdOcmhH?=
 =?utf-8?B?QStPYUNDaU5sZlBzQk9tSzFXd3lOaWFabGIvSHRITzRKOFIvLzBIdU5OLzI4?=
 =?utf-8?B?dnQxbUhUWlZlS1hnVlpZQVlkcU8vRFh6UC80MiswU1hBL3RSakpQQk5MTXlY?=
 =?utf-8?B?Z0lIbzkvbjZLRmJNSjhPQkRTL0duMytKcVI1NUZaZ21EUVdRQzdHRGNRcmJw?=
 =?utf-8?B?aStVTjBUY3JOTHpRWCtGZ1N6RlN6TTdlcnl6b2VKMEwybXZPNndkZnNyTEM2?=
 =?utf-8?B?VzA2ZVZLSS9wd01SVFo2QTdiRmd5RFRwT3R3SjdIL2tLRUZGNTd1SGpYNmJm?=
 =?utf-8?B?b3VKZTAzNGxEVVdjSzd4WG1EQUQrRUR5OVFhb080SGNMRWsrTk9aVGNMakEx?=
 =?utf-8?B?MG5zSDhTeVlkcUk1enpDeGFKVEVzaCtWUEh0MlhzQzl4M25iczRoLzg4UmM0?=
 =?utf-8?B?N3BnaEJ1a1QyTDM4eTBnTGsxV2tIRjQ5dVBqdGVlMXB4V3lRa2IyeS9kaFov?=
 =?utf-8?B?NUFndTdITFllbjJJb2EyR3ExdDZhQmVpcnFCczNvZVBqK3drQitHV2hGeW8x?=
 =?utf-8?B?azl1aWEwK2tlaDFiMHhXQitmNDZsNlowV3N0WGdUSVBVTjZmTkZuSHZ1QzNm?=
 =?utf-8?B?S2d4Vm1ibXhlS0pzQVZ4YTlPQjcwcW9jUWh6elpOV0pZOS9tRmswZUxRbCt1?=
 =?utf-8?B?UXpEc3UrMlJNUmRCdUxVaDkvaG94Z2YrZWg5MFBMOEdWeEJOd1BmZDRRZXB4?=
 =?utf-8?B?dHJ1SWxVNWQyQ2tWVzhqZERlNURJOWI0VGt5TEN5YlJ0NGVuOVZSNG9JeEVR?=
 =?utf-8?B?MFZkWkhsSGR3OXVUTlRRYUNaQUhCU0VGYU01Q0hKOFYvand1d0RQWXR1N2Ny?=
 =?utf-8?B?SzVuRGNnZTZ1RnRvY1BPdUViWnJZbmwyMFRDVUtjUDZ1V1UzU1lETUsrRU9E?=
 =?utf-8?B?ZWxTdzJINXF3WVF2VXk2TnBzZzI1bDdKdzVCVWVPQXhZbnVaS3JSbGdSSXVs?=
 =?utf-8?B?TU9QYjVObUIzQXlBQ2JIdk1RcGd0a3BEU290MVJKWXpydjVmZ29EOENUc0FJ?=
 =?utf-8?B?LzB5VHhUcW8rZ3lUcjl2VE0wYVYyR21RK0JIQkpPenZYWWx2QjkxSCtuYjJW?=
 =?utf-8?B?a1YyRUZwMFhiaUdJUG1ocUFGMWQybFdNalEvWGtCaVhEenozNnFJVUxvSFdE?=
 =?utf-8?B?YWN0YnlBclRxa1dyZDcvNDhoaUR0NUNCTk5lTElqUkU1MGl1VEE5aERUUllh?=
 =?utf-8?B?OFZXVzlZMUJPQkREOERMbGxTN2VBM2UrdkVwUm9TK1BtZ2tYRHBHdkpYVFBU?=
 =?utf-8?B?aldhQnd2TVpGcmYzNFlnZjd0NzlWZnVPbkJsc2EweEhObHB6WmVFeXVzeE4v?=
 =?utf-8?B?TC9hTkFrTEM2SlU4U2ErZHNkT0hxMG5la29jZmdrYWZEZ0tzeDJGNFk3QURn?=
 =?utf-8?B?NzZValgwTXh1YXpVQkJFdlczOUpYelBoUVlGMzh1UU9XWXEyc1FydnJOR1Vs?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46D202D705063042889DCF66F9AECB7F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pfmq+qAosj3XJS149DVCmtskid68P7FNFI1PmpCtUpqJUw9i93G0u9dhhmSh5X/M6lPEqegotLhD+4K6cVkGrch3yzh8/EXr7eL3bPkpjaZL59vBfR1aH2WI19YejtCoqntOhraKE6Ofloj6sYrR4FpKerVui52MOn0GTxlTOJ/9FMgc9DergSU8XsmspNBrCIg9lhdTSiiK/70ErwE0wP7XJ5zmr3TE8uvOdfWw8iPjK5hnM7rLnOTIn7TIA4LbWr/4omFw+tplPUiCI1kzhhJQUaoLlE2r9fAvnNHbbvBvdUcfp/AolAwRf53FsC+jfEWUCQ/sxUjjUsLYKSyx7kC2P3sTsagDO3WJe1KV1RIispsOaJC+De78WDLwr11Pq34CIkpQ3TVm0FkK91fdaObp2LtuOedEOJ14DrMv9ZrbhXSEh3YJcXyJ/LIrbGk7neHUBOLHKneMl6Cjuq0vkGIALwu7fhQOOKFMSbWdr6LeW3z5jGmyLFSpVvW2yEEv7liQ1E7ft7ibIuLi3VEOEChC503++exOZSWxlrFtbvPnyOWtpgi2Zn0HMZoYWDWC8vd0OLn6TTCTuTCgDxXA5oEu7CbjBvg3ZUOtmwy9+LjsfurqzQKDYqYBYumoNPIn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8c6507-95a7-4fb0-eda4-08dc63907b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 12:25:37.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idkOQlnAKtWrowSgBBPO56riLs660WbUmNmlw/mTp9O95S2ZX4LJV4wrnD2vAIuoz+xXHUfG9XSOkSlM9FUogqvsRqpSoG+ZTnCoCUqpb6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6983

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

