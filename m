Return-Path: <linux-fsdevel+bounces-7533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 722BA826D21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB47E1F22709
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54C322091;
	Mon,  8 Jan 2024 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jfv5n3Ge";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dzXHvFJd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0598724A16;
	Mon,  8 Jan 2024 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704714444; x=1736250444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZULCkicFSjSNQrK96cgOLm0rNAC/9y+q+pygE7APexk=;
  b=jfv5n3GeGlsa5nLQfKB6/pT3bEnUNLb5/FRVThyvS6/XWV+5zu3bRCeo
   ZtXUB15tfEt+s+8IwJuLiheEHNQySVfsnaShcS5Gb5CAXx9m95m9N2ZmM
   MGEtIeOr40KJxWyQ4SUKWbsCVi0/7f+4/GExa7Eo9MCLagiy+m5wPL08D
   a/YfJwQzPofWEyc9ZJu7pk5YBCngH+ILFDi5etpf089FZGsvq8TBne4Ao
   z8e8sK2FfvTM6KK7WWQTHuMGy+IkbtH1Cxejk07qVGMTsPJ41KJpjfnFC
   JBvccnyZcbQMcrF4KSK+uEaIzf8hpi4JI5jt/Yd7qvmqPmXVjufXLVur7
   A==;
X-CSE-ConnectionGUID: IJHZujtIQN2w6uPkxs6LqA==
X-CSE-MsgGUID: v40WYlTrSHK+dvH9TkUI3w==
X-IronPort-AV: E=Sophos;i="6.04,340,1695657600"; 
   d="scan'208";a="6367674"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2024 19:47:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPfQjdZcjJXIE9gKYa11a9HbVhfgScCeluYCnG0uEREysgsPy6WfE3UTENJ6XaxLP+7tkn/t+QvFUhx0FBXBhWGkbi/YwMTMUdlFpC3WlMgJZGqBIPQB1lhfdLeomAGc/Rf1x3+zOjUuUsFPmkUCK9qw1/qxvwC9J/uh4/7MaMqeVjdPX3oS81c0nkUKxV5XxjdRL4I6sBuwNPR+GGxJuqfVa+E08gh9p+lhAtgvjHU03LH9ruFi1Jvd6JaaMwafKeWzwQrwpUF6PtJGpTj8lbgXIXmPkkguZK9B4gdBPj+f90JaaJUI3FgFPo5pJQeviT0zBKONe1S1J2aZIYGptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZULCkicFSjSNQrK96cgOLm0rNAC/9y+q+pygE7APexk=;
 b=NSTiEausRPzuci4sshwHHqP4TqX5E2FvGIS6s1fsvuDx3p3v1NPnaj81HtdR++c81cA9UiKW/B05GPfcmWQd0I1qD2oVMUTrs1zR9BDQPCjxpzSYuWbHOzTeIUjjVh+KtxdDitsiOO9B9osnPRZ8KUiiyS45Ob1qd+DV7WJwqIgRrukP1WFE1pTz3uiciVcXmm0zfu1PHlEz2qw9DZwTfUqw1HlhxtC0eZ/VK7/xCHE7OA1tTen/LI18hN2HUUfcZ2cnU8HHSfR6RPlF9NTfJVUURd3WwZ4M0IWTQilhZp7corC4qEshKB0+N0TRLcbfXsltlbkyDMAtCzrwCue3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZULCkicFSjSNQrK96cgOLm0rNAC/9y+q+pygE7APexk=;
 b=dzXHvFJdLanFseXN/ZEw0AwIaRwYMBA6UVYGBTTnb5JgM4ggv+9o5xf4z5ZJetXt103mzireBisjqN+CGLgaG6c0B9RdyoiyIcuOujJ8U/jVLyOfbi9PoYp2BarNMf1YXOtOP72fl/X+a+IphAHn7UD8M4KbbobfthApNG/NVCc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA0PR04MB8889.namprd04.prod.outlook.com (2603:10b6:208:484::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 11:47:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 11:47:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Thread-Topic: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Thread-Index: AQHaP1N1f1xtm7GuQkGyfOpNi6HK+7DLDVQAgATE2YA=
Date: Mon, 8 Jan 2024 11:47:11 +0000
Message-ID: <20f3de31-fbb0-4d8b-8f34-aa1beba9afc9@wdc.com>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <20240105105736.24jep6q6cd7vsnmz@quack3>
In-Reply-To: <20240105105736.24jep6q6cd7vsnmz@quack3>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA0PR04MB8889:EE_
x-ms-office365-filtering-correlation-id: 02511648-1310-4d8f-4560-08dc103f8d33
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rLMEHCgQR6RilSbDxqj2S2BBXcK97hkEWGk0bbHxbdMJTZfU27MZLKfHyP8IVJHY3E69GDWVaSweTzjA7syDA5BT72i+Vmmpcs2EOKq6dOTS4wLrHVWPUniInv1qYrWVTln1tVaQ0+ojPRAEHtaQSIokkrG3fMT/0QqawjdczwjYpIJZ3Y4fp/TFUXM3E3o9lF2pHW1MeZSYQk0eUi9BErAAHxwj0NLIU6EMZQyYvfy0T7MvRZu1uARbE0VdBGI6set529aSZuvd3jCBHxJyNWgdoiV8Ve2vZrSUuJ0iWUoAvadUj/ht+WDc4pwIOYF/yNrhEEAacnI0MHmK0gEn9PjH/s5F1XrZ1oxKBc3aKwKhmn4FjPfW+YB7/178IhlCcyjZravBvkD4POzyoElehTgLhcnuestomt4nYYsKLhaou4eC55msn1AzoBf1Shn8Kaak6EpQUAoIZSQ8HnV20izbkvGs2CCbyDiqj68s6eORKVSGDZkR7OiwGq0Xo1zvWbcQiRDiq2NmBX0FUEoh7jOIVkEdRVXvthxsOZxiUsq98asZ0pMsoaUNAMqFl13AbifqkNaa580v9HOhWvR7idVLUPuRA0J3ZKnU+hzwNB7AMJnHYlqzYZ5XqS1A2IngBKdU4uTRKaHYOicYU3cmL0zI+RhhxDkPlSMZsKsM3Fs9XfGg25VdM64i9ZlR56jB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(7416002)(38100700002)(2906002)(6486002)(2616005)(76116006)(91956017)(66946007)(64756008)(66446008)(66476007)(38070700009)(66556008)(41300700001)(122000001)(31696002)(86362001)(31686004)(71200400001)(36756003)(66899024)(5660300002)(4326008)(54906003)(316002)(110136005)(53546011)(6506007)(6512007)(83380400001)(478600001)(82960400001)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHMza2g2RHBiTk9nWWROSndLcFhLYjBKdHFuK2dYU3FNZm9sSSt5bkZCUDRa?=
 =?utf-8?B?S1c0WDNYNE5xVjZqaXRPQVJsbzVQM25XMFhQTXlza3k0MGQ3Y01OODNhVDN4?=
 =?utf-8?B?R3VORlhZclUreXdvWGJUUi9nNFZtUVZVUlZWRnRWQ3ZxUXVUQnFPUEdKYWM0?=
 =?utf-8?B?bUpib1NWU3Jwc2hzRy8xNkwrYW8xbUR1SEhvQmJCSjhpdXFPNlRLQmpIbXlD?=
 =?utf-8?B?cXNINTBHR3Q1UnVFM2d6Qk1EODVESjEvZEhXa2NKZC8rNCtvUUJjbUxPbHcr?=
 =?utf-8?B?VCtoTFdvOUE1UUFSbDJkUDJNVE5sYXp2MXBBci94TVRDRW5xMmM0aWV1UGVK?=
 =?utf-8?B?T0VxVmZTNzAyRkVaMzRqK05KOTlQTGZhUlNxM3FtNW1IWXd3bXBWRVh3SjZi?=
 =?utf-8?B?WXcxVFZZMnNZZU0zK0dqd3lzeWhnR0hoU0VaQzNjcjJOVi9qa1ZXQjBJenVT?=
 =?utf-8?B?NVdhT01abnhac2dPRWYzU2ppNHQyTkpHZGRHM00rdWM4dFJmOExXenpDeTVu?=
 =?utf-8?B?NGlJd1VXWVZYamFjZFR6c0tPWDRUcFhnakhiN3EvNDMwamtFdXVlSUFUc0lZ?=
 =?utf-8?B?VnJZN2pncjVJNExSOS9BRU91ZTc0YlVZYzMvN0piaDYwdFRpTU5hcWRrY2N3?=
 =?utf-8?B?ZytNT0JwSG1EVVFCbnh3TFBxeUh2dy92dlMyU252UjF3N2VjaDNUck9pditZ?=
 =?utf-8?B?NlpzM0tXRGJyYlNMb1ZsaEZoSWxCZmpCQXNSZlYvbUszckZzK3FGRWk4aHhC?=
 =?utf-8?B?ZlFuTDFDV25zY1lJVkN0bUFVOFcyWCtSNDlCeWt4c0wwN0tXVWJteGhMNmNC?=
 =?utf-8?B?U3kvNURqUXpYMVA3Si9PNjZtbkNxSHdKWmc2MW5yTWxLeDYwckwwaW9Vanc5?=
 =?utf-8?B?TFUxT2Z0Z3dic1NBWFowYnBVUDhlYkdCaHg5SlZvUnFORVFUSEFnOWdjMkNa?=
 =?utf-8?B?bGoxd0w3L0JxNU5ibXUxNGMvajR5KzFFeEI3dHhveTlFd2NSZ1I5NTBZQjFZ?=
 =?utf-8?B?Y3VVVGZWTWxaeVhxL1J1aGJVRDdscjlVaEJUSjh5bml0ejRRMzhrUUo2STNQ?=
 =?utf-8?B?SCs4M3h4QWd6MzdQclhKcXVwQ09Kc2ZUOEw5WHc5c282Wm1oTmRGY1RJTlVp?=
 =?utf-8?B?SVVHeUlqN214UG82ZDFOWjJPSms4SGo5cGJERnc1U3F3ZDR2Z29oeUp4N1g5?=
 =?utf-8?B?WGhBMVI5U2wrTkZxVlNhZGQ2NlJuUjIxREhidUo1Tzdkc2xPcnIzNjlQbDl6?=
 =?utf-8?B?QmJhY0pzTXRPcldESmZlZy9Wdytsc1g2VVM1UnExWTRIUEpyVUI1b0tLaWtV?=
 =?utf-8?B?UVJmdklxSW16d3JZWHpkaUZLZVFhbUdFZmw3RmZJYkdzYzdCcEJnWDdoV052?=
 =?utf-8?B?UVk0ODFtdGdtUDBMYkd6ckpRSThCN1VTdEc1dWdpclJHb2NMeEpEM3VjeTRO?=
 =?utf-8?B?Tk9oQVM5SFFNRjhDUTBUbS9WZTd1NE1WaFhETVl3RStlMFlBekFrTWRuanQx?=
 =?utf-8?B?c3ZIdUlXNjlkQU5PODZ2Y0F4KzFrNUtMeGc1L0ZxSzdxZWYxQUFiRkwxbHdy?=
 =?utf-8?B?NjNzbmxxL1lUSUl1b0xaL0ZTSjRvWUdsbkZ3bEFUVnN5dlpSVEljY284c2RJ?=
 =?utf-8?B?bFEzUnNLeG1yd1N5a0kxSCtwbklaVFpIelp0ZCttVFVFZzN4L0VZSDFTMnZj?=
 =?utf-8?B?Y2xWb2c0VXhFb1FFeHlUUWhicC9hWlp5blFZUTI3T0kyV1lnS2tWZDhOeXk0?=
 =?utf-8?B?TmdrM2FiVzcyRlZSWlFlcUVVYmF4UkpzU3ltUUFrcVY3TEdLbU5mSjRSNlF5?=
 =?utf-8?B?cFdOVkVKR2F2S1JENjNGUXBiOW1RYUdXR2lvUE1wdVBoNzVIOXhuNDA4VGJZ?=
 =?utf-8?B?NkxpaFVWZENUVmJBNFU4TzFwUUVtNitGTGRJeWxMckRiKzE4eno3SjBhbU9W?=
 =?utf-8?B?VFArRUdEN2UwWjM4WDhNTXd3Z1pNU1RCRklkMDdaVHAwY3RBb2tIbXVHR09N?=
 =?utf-8?B?aWRRNW1VdFJnRGZ4YVVVOEdXYkhPOEQ0MzVkckdraXI0YXk3NVlWYlR6Qi9K?=
 =?utf-8?B?YXgvQi9NeTBIemJpQytKTGxhQXlqbkdzR2VmdERRZEtiZ2lBZGV1cXZ1UmhE?=
 =?utf-8?B?S2RLTytCbkZBVDNoZGZMTVRvVHhKdW1vdGlVWTFzNFRETTdLUjZyZ3dtdjZW?=
 =?utf-8?B?eXNjTUFaVmxJQVBveWUvVUk2c0tVNmZUN2VKaktYSmxjem8vOGxxUUw3cTFh?=
 =?utf-8?B?cmRUQXBXNnNhR2xEb0ZvLzZ1dldnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED8CEF284AB49D40884930E019254474@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N39wcDRcvgJe0VkcqbGhvM67ux6V/C2RKJP9QVB34TLIHGoRR3Fztws7xXZVxOfQ7jaFNELZw6a4Lb1QybGAt/Z1urh8ywtd0JXupX/UeqfzL7aHsU0PtcWcFFZa0O4kaD+bFD6iv2bsffh/rD/qNFmliwlWmbmZA+VWJ9xytnRf5YjBy1ulXx+Du08TM0MQ2vbq7itt0cYoLZkgOeS1xGNB+jfWHJYhmIxo0I+Ap7SFiIWVQILXbLFtzk4I5HTzEaXbeD2CBRrBWffv6Z4OHxM/oT3CJ6VdYIzi9zZHwMgfH5CfMcK3ilVO97I1piV+FwmJ5jhDlVcTrvlhx/5walaa49hdJlWa8p7Mch2pQkBDitXf0AVmhViG3nfPJQp3lOg/HMO6EUxXv+gAkYsnX8AMePdCm1i+LdK6AFb3J+60Tmsi4z0s/7z1hbRBda4d9fBDrPqSBB7MyCEwznqxdzbhGTcq3xSNKF9eAEorSBaDx8Z1iYshrTDNUZ07/hAANTcsWPgFx3aBMuisJ53bBmsFXFGNLdoZSk6SHw0OJ8E9dToGTPh57to43WEXj0l/7lyUIo+D+tCK27of2FyIOwDU5BZ3LuNNMNPC+PWZH9Y+yk/SyOdSRNwCXa72xOqy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02511648-1310-4d8f-4560-08dc103f8d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 11:47:11.7161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2q7VpFLvEftVNVe9/blQrhU1BMgX50+HPgFlZ2c8G68qPxStqMggdZY4WkaT4tDv+ecyUHsrdTbleGenmgdWGnose7T+R6kc5WRWoTKQCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8889

T24gMDUuMDEuMjQgMTE6NTcsIEphbiBLYXJhIHdyb3RlOg0KPiBIZWxsbywNCj4gDQo+IE9uIFRo
dSAwNC0wMS0yNCAyMToxNzoxNiwgTWF0dGhldyBXaWxjb3ggd3JvdGU6DQo+PiBUaGlzIGlzIHBy
aW1hcmlseSBhIF9GSUxFU1lTVEVNXyB0cmFjayB0b3BpYy4gIEFsbCB0aGUgd29yayBoYXMgYWxy
ZWFkeQ0KPj4gYmVlbiBkb25lIG9uIHRoZSBNTSBzaWRlOyB0aGUgRlMgcGVvcGxlIG5lZWQgdG8g
ZG8gdGhlaXIgcGFydC4gIEl0IGNvdWxkDQo+PiBiZSBhIGpvaW50IHNlc3Npb24sIGJ1dCBJJ20g
bm90IHN1cmUgdGhlcmUncyBtdWNoIGZvciB0aGUgTU0gcGVvcGxlDQo+PiB0byBzYXkuDQo+Pg0K
Pj4gVGhlcmUgYXJlIHNpdHVhdGlvbnMgd2hlcmUgd2UgbmVlZCB0byBhbGxvY2F0ZSBtZW1vcnks
IGJ1dCBjYW5ub3QgY2FsbA0KPj4gaW50byB0aGUgZmlsZXN5c3RlbSB0byBmcmVlIG1lbW9yeS4g
IEdlbmVyYWxseSB0aGlzIGlzIGJlY2F1c2Ugd2UncmUNCj4+IGhvbGRpbmcgYSBsb2NrIG9yIHdl
J3ZlIHN0YXJ0ZWQgYSB0cmFuc2FjdGlvbiwgYW5kIGF0dGVtcHRpbmcgdG8gd3JpdGUNCj4+IG91
dCBkaXJ0eSBmb2xpb3MgdG8gcmVjbGFpbSBtZW1vcnkgd291bGQgcmVzdWx0IGluIGEgZGVhZGxv
Y2suDQo+Pg0KPj4gVGhlIG9sZCB3YXkgdG8gc29sdmUgdGhpcyBwcm9ibGVtIGlzIHRvIHNwZWNp
ZnkgR0ZQX05PRlMgd2hlbiBhbGxvY2F0aW5nDQo+PiBtZW1vcnkuICBUaGlzIGNvbnZleXMgbGl0
dGxlIGluZm9ybWF0aW9uIGFib3V0IHdoYXQgaXMgYmVpbmcgcHJvdGVjdGVkDQo+PiBhZ2FpbnN0
LCBhbmQgc28gaXQgaXMgaGFyZCB0byBrbm93IHdoZW4gaXQgbWlnaHQgYmUgc2FmZSB0byByZW1v
dmUuDQo+PiBJdCdzIGFsc28gYSByZWZsZXggLS0gbWFueSBmaWxlc3lzdGVtIGF1dGhvcnMgdXNl
IEdGUF9OT0ZTIGJ5IGRlZmF1bHQNCj4+IGV2ZW4gd2hlbiB0aGV5IGNvdWxkIHVzZSBHRlBfS0VS
TkVMIGJlY2F1c2UgdGhlcmUncyBubyByaXNrIG9mIGRlYWRsb2NrLg0KPj4NCj4+IFRoZSBuZXcg
d2F5IGlzIHRvIHVzZSB0aGUgc2NvcGVkIEFQSXMgLS0gbWVtYWxsb2Nfbm9mc19zYXZlKCkgYW5k
DQo+PiBtZW1hbGxvY19ub2ZzX3Jlc3RvcmUoKS4gIFRoZXNlIHNob3VsZCBiZSBjYWxsZWQgd2hl
biB3ZSBzdGFydCBhDQo+PiB0cmFuc2FjdGlvbiBvciB0YWtlIGEgbG9jayB0aGF0IHdvdWxkIGNh
dXNlIGEgR0ZQX0tFUk5FTCBhbGxvY2F0aW9uIHRvDQo+PiBkZWFkbG9jay4gIFRoZW4ganVzdCB1
c2UgR0ZQX0tFUk5FTCBhcyBub3JtYWwuICBUaGUgbWVtb3J5IGFsbG9jYXRvcnMNCj4+IGNhbiBz
ZWUgdGhlIG5vZnMgc2l0dWF0aW9uIGlzIGluIGVmZmVjdCBhbmQgd2lsbCBub3QgY2FsbCBiYWNr
IGludG8NCj4+IHRoZSBmaWxlc3lzdGVtLg0KPj4NCj4+IFRoaXMgcmVzdWx0cyBpbiBiZXR0ZXIg
Y29kZSB3aXRoaW4geW91ciBmaWxlc3lzdGVtIGFzIHlvdSBkb24ndCBuZWVkIHRvDQo+PiBwYXNz
IGFyb3VuZCBnZnAgZmxhZ3MgYXMgbXVjaCwgYW5kIGNhbiBsZWFkIHRvIGJldHRlciBwZXJmb3Jt
YW5jZSBmcm9tDQo+PiB0aGUgbWVtb3J5IGFsbG9jYXRvcnMgYXMgR0ZQX05PRlMgd2lsbCBub3Qg
YmUgdXNlZCB1bm5lY2Vzc2FyaWx5Lg0KPj4NCj4+IFRoZSBtZW1hbGxvY19ub2ZzIEFQSXMgd2Vy
ZSBpbnRyb2R1Y2VkIGluIE1heSAyMDE3LCBidXQgd2Ugc3RpbGwgaGF2ZQ0KPj4gb3ZlciAxMDAw
IHVzZXMgb2YgR0ZQX05PRlMgaW4gZnMvIHRvZGF5IChhbmQgMjAwIG91dHNpZGUgZnMvLCB3aGlj
aCBpcw0KPj4gcmVhbGx5IHNhZCkuICBUaGlzIHNlc3Npb24gaXMgZm9yIGZpbGVzeXN0ZW0gZGV2
ZWxvcGVycyB0byB0YWxrIGFib3V0DQo+PiB3aGF0IHRoZXkgbmVlZCB0byBkbyB0byBmaXggdXAg
dGhlaXIgb3duIGZpbGVzeXN0ZW0sIG9yIHNoYXJlIHN0b3JpZXMNCj4+IGFib3V0IGhvdyB0aGV5
IG1hZGUgdGhlaXIgZmlsZXN5c3RlbSBiZXR0ZXIgYnkgYWRvcHRpbmcgdGhlIG5ldyBBUElzLg0K
PiANCj4gSSBhZ3JlZSB0aGlzIGlzIGEgd29ydGh5IGdvYWwgYW5kIHRoZSBzY29wZWQgQVBJIGhl
bHBlZCB1cyBhIGxvdCBpbiB0aGUNCj4gZXh0NC9qYmQyIGxhbmQuIFN0aWxsIHdlIGhhdmUgc29t
ZSBsZWdhY3kgdG8gZGVhbCB3aXRoOg0KPiANCj4gfj4gZ2l0IGdyZXAgIk5PRlMiIGZzL2piZDIv
IHwgd2MgLWwNCj4gMTUNCj4gfj4gZ2l0IGdyZXAgIk5PRlMiIGZzL2V4dDQvIHwgd2MgLWwNCj4g
NzENCj4NCg0KRm9yIGV2ZXJ5b25lIGZvbGxvd2luZyBvdXQgdGhlcmUgYmVpbmcgY3VyaW91czoN
CjEgLSBhZmZzDQoxIC0gY2FjaGVmaWxlcw0KMSAtIGVjcnlwdGZzDQoxIC0gZnNjYWNoZQ0KMSAt
IG5vdGlmeQ0KMSAtIHNxdWFzaGZzDQoxIC0gdmJveHNmDQoxIC0gem9uZWZzDQoyIC0gaGZzcGx1
cw0KMiAtIHRyYWNlZnMNCjMgLSA5cA0KMyAtIGV4dDINCjMgLSBpb21hcA0KNSAtIGJlZnMNCjUg
LSBleGZhdA0KNSAtIGZhdA0KNSAtIHVkZg0KNSAtIHVmcw0KNyAtIGVyb2ZzDQoxMCAtIGZ1c2UN
CjExIC0gc21iDQoxNCAtIGhwZnMNCjE1IC0gamJkMg0KMTcgLSBjcnlwdG8NCjE3IC0gamZzDQox
NyAtIHF1b3RhDQoxNyAtIHJlaXNlcmZzDQoxOCAtIG5mcw0KMTggLSBuaWxmczINCjIxIC0gbnRm
cw0KMzAgLSB4ZnMNCjM3IC0gYmNhY2hlZnMNCjQ2IC0gZ2ZzMg0KNDcgLSBhZnMNCjU1IC0gZGxt
DQo2MSAtIGYyZnMNCjYzIC0gY2VwaA0KNjYgLSBleHQ0DQo3MSAtIG9jZnMyDQo3NCAtIG50ZnMz
DQo4NCAtIHViaWZzDQoxOTkgLSBidHJmcw0KDQpBcyBJJ3ZlIGFscmVhZHkgZmVhcmVkIHdlIChh
cyBpbiBidHJmcykgYXJlIHRoZSB3b3JzdCBoZXJlLg0KDQo=

