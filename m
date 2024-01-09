Return-Path: <linux-fsdevel+bounces-7587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2F827FA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 08:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9951F22098
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 07:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BBEBE47;
	Tue,  9 Jan 2024 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A8IpG+m9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G7dr0fAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205109455;
	Tue,  9 Jan 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704786246; x=1736322246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5mllbLCSlpPmxfmQn62gUmlzq153EiTspQkjVxfdy0E=;
  b=A8IpG+m9RfUmB+ieUk1nU5A7xpEHZjKcZwVIwHPmKeuiCZ7xWRryNyGK
   mbXk1esAHc3r7gLWj2TL8F+kG6qt3R3173sDCKNg3/Ka0Ej1MJyJvKveO
   a6xN/RAdMUjO+YLH1PPC7URfUXb6Lctvx5D1v/7rDDp1FktZerZvBUmha
   nBux8ejKc/Rvy7m2HT+cRtYNhY75OuqPqdl/TzA68yuOfBbB+S8ZE0CFB
   GB9/y8YjEUabK2Kna/o5XL+CavQhvB6MFBDBr3hV+8nGT9/lOf+YBUsfX
   gV1Pae+WOlH+DUEWw8+bKqP6cBx6bYLoFOklwREF9tvZAHVY9TSAJGXPg
   A==;
X-CSE-ConnectionGUID: e3w/zofbT+egGCzBAdlw7w==
X-CSE-MsgGUID: hIlUrboOT4mm3Duxtn2gww==
X-IronPort-AV: E=Sophos;i="6.04,182,1695657600"; 
   d="scan'208";a="6552229"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2024 15:43:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxVfa/Cz50fBVdajEMBk8hXWbuHndu4DD2CbbKU2uo5yyKW8C1KAtvpYG3/wDDY9OQo4/Nqm723VDhqei+wOo7cBtawRFiyAyXTIcpJuRNJrDtyBTJZsv2eSCT6uP5BPbpBSx59EGQLF2tD4rC306+xcDEq08jP3dhAh1uISJ6TdClQNsI5scat6feYkb9TjSVuuFV9BO/EddU1EFxfb7T7jwjnY29R7uEtK4srrz0xMYB9xU0gzq1weaDHHCMnJ2iJpxfG92I4aqpd3HzjVo1WJJ1JeYjjaWab9KoUz/mdxVRhrLq05Xp3j3FVlz+9CLS9kkQJLwPCnG3PyAkzpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mllbLCSlpPmxfmQn62gUmlzq153EiTspQkjVxfdy0E=;
 b=Uh2zgnPxaIumPyetqSFAn7PCNLdDmBEWWTxsT99CrVbSgjjuL0qSufuOdtufU5lyfpHAqC5FMK/UoyKSti50z0VWrRg85RbpWb1iSyQsuGEnG1uhB2NcpbqFagT9Al6zGNmKLkclPHkGXZ3TOe3PZsxttjn6uJV5VBbN//6OlnXKtg4VrkIxtQ3tka84RG0Hx0UaM3BYa18ufgmslp5lNULJ5NIL7MNpzeDTYZpJdgPwkjrTBHpjxJr9wqLpHLSVIOQtm/5ap8iXMMIr6EkhkdPzyAuXhTe9FN/q0Y9cuT9cZ1rUFhoszxaQK4P6T5urrwdyciLf5rVxGTkO0PsFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mllbLCSlpPmxfmQn62gUmlzq153EiTspQkjVxfdy0E=;
 b=G7dr0fAaZpHH1+oA0s1J+uKRFZqsHv2JkH/k7Td40uB12ifcVfipH8v6cxeF7WoOOWI8T8Uz3+ZyrP9ilzloOMbjpq6PGZVlVS1ShhoeHgARXzmJ0Xje/V6xu5qjMSL473a1RHFFY6CNmftSg7XwlEDL6iL54Oq80P871J3xMQg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8689.namprd04.prod.outlook.com (2603:10b6:806:301::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:43:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 07:43:54 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Thread-Topic: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Thread-Index: AQHaP1N1f1xtm7GuQkGyfOpNi6HK+7DLDVQAgATE2YCAAGJtAIAA6+8A
Date: Tue, 9 Jan 2024 07:43:54 +0000
Message-ID: <b5bc1e72-72ea-4b67-86a1-3d41deb5bc72@wdc.com>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <20240105105736.24jep6q6cd7vsnmz@quack3>
 <20f3de31-fbb0-4d8b-8f34-aa1beba9afc9@wdc.com>
 <20240108173928.GB28693@twin.jikos.cz>
In-Reply-To: <20240108173928.GB28693@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8689:EE_
x-ms-office365-filtering-correlation-id: a8a0ebed-9ffb-4f8d-445c-08dc10e6bafb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7a1UJI+EnbHjvQ5fto8IDOr5tTGj7UzsESCEov6wxq9C6st05p8AYcTZw0qwzLheBoZp157LfvdcTVzedeOVvlT0o6CEIBQTkYfRabHQ+reYUkQd/VrslJvcQqla3kEGwXc9F5mGMjNE1rOZ4wuz2rY+CWpTCkNhsKIpuTfch024mSZ40PasrTT/iM2mXAk+Ogc7efPhDaxWL7mcSZubMCYHo6xtOuH0XMcWK676NRVEwyXqYQ3NnzC6irK90xoAY/ic/nw7tV+lwGXeCiOgtcUtn3EOkRyGvweaR05U7BR2Rex9C6TiwYW2u8gm9XUnx4mOQj/NMI4+8xQ9+tNVNm3Gws+PZh3lm8n1jETfS+rVXBKOCChEaFosOOwU/4YI4CI8x6wvfPqmrlJHjrboPGEW/CkZ3hMv1031l1ylxVb3iZXxOyL9MV1o75YRl6zPKueIaG03k2GwCrVkYaGsqyusCzLYCVc1lzZOs+qDa/xtMKO1sNMhouNUW3c+7OhbFRC1AkG3zVElzeXRTZVEPN44S3Q7VFHxJQfJPdhE1G9ZiB/1TSKlqXzwRaajjU0xZGXbEFAevRnCV/HBDIg+feO1ryBkXfg3g32UlmOgHMZZhCSAH8J52lanjbPgWwhFCv7RP9BkRH3P/GzFOdOBZw/gE10xuP3/9fp/XIu6pc0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6506007)(966005)(53546011)(2616005)(6486002)(71200400001)(478600001)(6512007)(83380400001)(7416002)(6916009)(41300700001)(66476007)(5660300002)(316002)(8676002)(76116006)(66556008)(66946007)(54906003)(64756008)(91956017)(4326008)(66446008)(8936002)(38070700009)(2906002)(86362001)(38100700002)(122000001)(31696002)(36756003)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkYxcE5GWmliaW1VT1dIcmlRZVNTV1RJdWZPYzBPYTh5REVuY3VLZEJaSk5U?=
 =?utf-8?B?TGdVcmkvVHhNK2R4eEIzTGtwbDZkTjI4SkVuT2ZvWlBqdGVxNVh0ck9lOHZn?=
 =?utf-8?B?eE85RnJlVW5xdW1ocWVxYmxlMUxLWGNFa01JdEcwZ29QNVBRSC9Kc2RlQzZN?=
 =?utf-8?B?TGlIWGl1MTNtQ0IrdFJuVlBNK0doTTN1RmpRdmRoSGFNdFJOL0xaRVdVWENn?=
 =?utf-8?B?VGRxN0JRWWg4bWVPZnlsTWFqTkk0cUw0bEtkZHpPWFJheXIzZWlEZW5yVlRt?=
 =?utf-8?B?Zm5RTlp4bk5hUEtReWcrRUZyS0t2Sy9aczV6dzlnMXJHR1podG1NUEtlbVly?=
 =?utf-8?B?RXhycnE5WHg4NXJ2SnhRSEtqNFU2cjNid3hIc3p1aXNJRHgwd0tBOVYrVXVH?=
 =?utf-8?B?K09DOWdiejNCUkZxamJaUVhBcU1HRUVyS2JJTStrbkhOR2daWEw5cjdXK28x?=
 =?utf-8?B?Y2RPa0h4VVVLRkVvbmtYK2J6MVdIYkF4UjVYRkFYMDFGTkdybnUzZmxsdmNi?=
 =?utf-8?B?Nmp2aThrOVI2S2JQVm1mZERXSGFYUUlLaWY1WUZJTUdkTG8zdDB2UWJrU2E4?=
 =?utf-8?B?L254MzBVeER6ZVpLZzdpS2pvL1dBeHptc3NvSFp6Rk4vQlg3T2g2VlJTVi9Q?=
 =?utf-8?B?MDhTZGMxUUdBeWpWVmZFQW5BWjlNdnkvNnAzWkprVXA3NDRsdWNRZDBtcldW?=
 =?utf-8?B?bHp0WjIzbGVlUkNMNFR1WDRrMU1oUm5zajQwa08yV1J4aDdwSkdUd1Z2S3dl?=
 =?utf-8?B?NnkzRWRObmxLQUdXR3JVRUlIdkRteGZPcnFTZ1RCamlOYVk1T3lpaEN1dzh0?=
 =?utf-8?B?VnE1TnhYNnVWWUcxVVVlb0NxQU5pMk03Sms1alRIRnhIRk9velQ4bkJlWjZl?=
 =?utf-8?B?N2JXZ3A1RkxZQ1R5WHRlTVp1VWhQY3dYblAyRjBrcVQyVSs3MmV4VWJJVFRY?=
 =?utf-8?B?NU9FRmNHMVpmQThscmdRUHZVOUgwT2piYnVENjNROU5TTmpRU1JUdS9TT0hv?=
 =?utf-8?B?TFJIZk0va3I0TTg3WE1yM1Zya2NoVnNCQ3dvUllPV254YVZSakxta0JjTUlP?=
 =?utf-8?B?Y0dHV2pkVmY3NW4veWQwSUxyeUZod1FtamR3bWw4SWlMbi93Z2lkcjBxVFlJ?=
 =?utf-8?B?WW93dHEwU0I4V3g5S2NZR0FnZ3BEdFdCWUZpTEZOTTdlYm5uMmNOUk40bmxS?=
 =?utf-8?B?YUhjd2dmejNLalpUR2tKQUIxOGwxbk1Mc1c0b0ZUTFNDMlBxMlh1aFZZVm5K?=
 =?utf-8?B?bHZ6UW50aUNJTVh5L3pGWGNqQjFibWVQZ2FNNTBwcXFDOUQ5SDJBQ2dMU0o0?=
 =?utf-8?B?VmIyWlI3NmFMYnlscmNGTzlwdkJoZWxtVVJ1Rk9zOFhjL0o0RUJmTUdmU1FC?=
 =?utf-8?B?UmpkUXl1Znc1NWV2NmNHeVppS0E0cnBBdlhhNXJzOStDSjRMTllWU1NTVWkv?=
 =?utf-8?B?RWNPREtOb1VQczdmdlUzN2NjdlpQMXM3TUZoazRpYkl4cm43NDBVRDBBdVpX?=
 =?utf-8?B?bHp4c3hDN3pkNW0wWVFxeCtOUm0vZDA4cG16b0U3ZGg4QjNwNWRSR0l4bHp4?=
 =?utf-8?B?RStYb2tKdElveTA4R2hjUWhjTlFjWjNLWGlwblVmekVwS1N0U0l5dkhIeits?=
 =?utf-8?B?OUVTRnlEay8xTXpsamwyK3cvUzc2WjRnc0hhajZIMG5YNDlQODRaU2gxQmxh?=
 =?utf-8?B?bWN3TEM5ak00TXRZOVFoNWlOTTJSRldwemFSajJlQ2tJbnNGOWZZMFR1SGVn?=
 =?utf-8?B?S2w3dkZvd0w2OThzbU1nUGtQQm5TOEJoQkwvZmR2eDR1WFg5K2w0eEppLzQ5?=
 =?utf-8?B?bjMxcFFVNHh0eXlNMml6b0U0Qm5hZVBMUlNPaTF4STFIbGk0WDFFdlFBUEtD?=
 =?utf-8?B?V1NJNzVuOEsrNGlmWVliem5BQk9zK3FRbVB3ZUlXNFZVQ3VZcUc3M3dqb3Iw?=
 =?utf-8?B?VDVoaGdpOE5RYW5VaGFiVlRiNnNTYVVqRE1zdk5PY0tNMGh2VUZIbGdmMjhL?=
 =?utf-8?B?THNweUJqcTVaM21BTHJvTExjbVZBYUxCOFdOYmlCK3VQODgrQWMzVlF5ZTRG?=
 =?utf-8?B?T2h6Ty9Dc2IvcDMyeWRBRG1MTVNGOGxLZC8vMlBIbUV1UGFPcmRoVm15SWY0?=
 =?utf-8?B?M1J4SmZ5WGdqQzlIb0NSZ0o5dzFFMmorV2VSVktBeDVKS2NCelhFT0RpQ3BO?=
 =?utf-8?B?SHBaSi9BV2FETkJ1bTlSNFg5UmJiUnpPWjZDUkNzMW1KRDZPQkFVcXl2NktT?=
 =?utf-8?B?b1VZaXQyNkJFd25ZVVZwT00xbTN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E14CED91164E24AB3B0D2934E8F9DA5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PY9VUwgf460akzDEUD/2rSLQQeNOAJy1Bc6fEhm/wiMTuBn6+jYCvQStRuj4QJIHF/1LvtxBKE9XKxJhwL8SRcEEwoclitQvCvDeKwdvfqZN+dWyeP9J6ue1mj/yvYVE+4MsQVnSufvBMXMiftdiRG7xDCLSx6cegA8zVjMduZn/Q11vWkf8iz82fcIP7znMH6zilubm3DRAuReKzvqhUTCX5P3NavoiBdIW1ot+Xm6g6jrq7iM6PapQdOSYm1eI3x+r17pcT+40DhGaahT4WEMXNzZkfNzGRz1wUA1aDGEdSe/nonEkFaJaSRHrFn8t0RZ1SRsblVMJar/MZ1Gxe7m0Y9ccxbaTf74xuguOsOJ4FXD0nP2HaldrCtV42w9C7DqE1+SjcLnhlI94Qbk2C2bU75O46rXc9LRd4hODJs/AnJu4xsSjzjgiDULAxbJ9ZA3b/UiY2X/lqODIdM+kaFCcTK4bktdWUQWQ1X+wOq2RLgyyXT5WgKn7BOeo4YhBHmX9xKbgTcJ4ayJo9CA1G4mlRDhOgT9kNyo7XzXT1xP2NRAW4QXVe35Y9IgeuPYtPC3XVl1055I/nJGGELlOWlKu3a7BVa5vsF1Pb12Gdg1wV65nn5gjp051HiUdWFmP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a0ebed-9ffb-4f8d-445c-08dc10e6bafb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 07:43:54.4606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgwV3mg/o4dseW5TCD6eTs7wP/HNRwiRwWB8YZHyiEiCugrr/gh+ZHijj20GFpce7ClgdVicBO8yeNMwqK/w3Afpyuz0bqMCnXVVoKCke+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8689

T24gMDguMDEuMjQgMTg6NDAsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4+IDE5OSAtIGJ0cmZzDQo+
IA0KPiBBbGwgdGhlIGVhc3kgY29udmVyc2lvbnMgdG8gc2NvcGVkIG5vZnMgYWxsb2NhaW9udHMg
aGF2ZSBiZWVuIGRvbmUsIHRoZQ0KPiByZXN0IHJlcXVpcmVzIHRvIGFkZCBzYXZpbmcgdGhlIG5v
ZnMgc3RhdGUgYXQgdGhlIHRyYW5zYWN0aW9ucyB0YXJ0LCBhcw0KPiBzYWlkIGluIGFib3ZlLiBJ
IGhhdmUgYSB3aXAgc2VyaWVzIGZvciB0aGF0LCB1cGRhdGVkIGV2ZXJ5IGZldyByZWxlYXNlcw0K
PiBidXQgaXQncyBpbnRydXNpdmUgYW5kIG5vdCBmaW5pc2hlZCBmb3IgYSB0ZXN0aW5nIHJ1bi4g
VGhlIG51bWJlciBvZg0KPiBwYXRjaGVzIGlzIG92ZXIgMTAwLCBkb2luZyBlYWNoIGNvbnZlcnNp
b24gc2VwYXJhdGVseSwgdGhlIG90aGVyIGdlbmVyaWMNCj4gY2hhbmdlcyBhcmUgc3RyYWlnaHRm
b3J3YXJkLg0KPiANCj4gSXQncyBwb3NzaWJsZSB0byBkbyBpdCBpbmNyZW1lbnRhbGx5LCB0aGVy
ZSdzIG9uZSBtb3N0ZXIgcGF0Y2ggKDMwMA0KPiBlZGl0ZWQgbGluZXMpIHRvIGFkZCBhIHN0dWIg
cGFyYW1ldGVyIHRvIHRyYW5zYWN0aW9uIHN0YXJ0LA0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1idHJmcy8yMDIxMTAxODE3MzgwMy4xODM1My0xLWRzdGVyYmFAc3VzZS5jb20vIC4N
Cj4gVGhlcmUgYXJlIHNvbWUgY291bnRlciBwb2ludHMgaW4gdGhlIGRpc2N1c3Npb24gaWYgaXQg
aGFzIHRvIGJlIGRvbmUNCj4gbGlrZSB0aGF0IGJ1dCBJSVJDIGl0J3Mgbm90IHBvc3NpYmxlLCBJ
IGhhdmUgZXhhbXBsZXMgd2h5IG5vdC4NCj4gDQoNCkF0IGEgZmlyc3QgZ2xhbmNlLCBzdG9yaW5n
IHRoZSBub2ZzIHNjb3BlIGluIHRoZSB0cmFuc2FjdGlvbiBoYW5kbGUgbGlrZSANCkZpbGlwZSBw
cm9wb3NlZCBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYSB0byBtZS4NCg0KQW55d2F5cywgdGhlIGRl
ZXBlciBkaXNjdXNzaW9uIG9uIGhvdyB3ZSBob3BlIHRvIHNvbHZlIGl0IGlzIG5vdGhpbmcgDQp0
aGF0IG5lZWRzIHRvIGJlIGRvbmUgaW4gdGhpcyB0aHJlYWQuDQo=

