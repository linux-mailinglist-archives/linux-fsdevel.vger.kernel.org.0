Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC16441E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 12:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiLFLOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 06:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiLFLN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:13:59 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277002655C;
        Tue,  6 Dec 2022 03:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670325237; x=1701861237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
  b=mWll78ZDO0MtPlhuouPu3h0sdSue6QpnhFVHlkDLrCIo7c4blV0gilJQ
   D8PPvG+VDQ0cpv/jSVglUGT8hz1ntGwD8e4zkzxYI51jP2sPFmtpmifMD
   t1WIoKtW+FGht7pPuVOEMYLpvvlYX9aIu9k8n2lfWtDOfXBRTtz6y1lBF
   jJKJ8aJ8CEhncDWVipxGXHh5Akl5pooV+6Zke4v/i0sWbcpxwjDFL5fjl
   fuxTxTeepq69yAHNbDsLVQDPzMThrEdCaF4LT6R44iIsPjeGU3SM6+WQg
   wWVR1jbp8CqRoobqZ07/A611423ERiFcY6Li57swwgr7UmVr9o83t/cdn
   w==;
X-IronPort-AV: E=Sophos;i="5.96,222,1665417600"; 
   d="scan'208";a="218269454"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 19:13:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwwZh7kYvuTQ3NGifU4OsKuK/iwf4dVnLxZlswF2etcvjCHUSWfTfJSkn1Xxh8QzDyHpxAkdnIa/g0wJIVlhmo3DA2TJieIi/pTdYM2lnC1FrhFl2aonMeYpvIfe51QSAMW8rLjUkfqF601Ps7P4rJWRFrmMTG60B5VIcs8lkMscLGuIqApFkdSyE2RJV2BzuicyS+LzMNTFZd9f82Zzwg+PNBPcGbNvXZqvP4R8UUZoUmWsJcLnJSb9QyQiFeDWrZo9ZLp4LZitxlipXVAbg9ahw8jQcv+w57SIWum2sjYsqZM1QBMlovG+WAC3RrfmPva+UlgRp1wZGbVfg6yUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=a4c1erLhYrZHydTFaH16rqjXrALCzoYA8wNOBwJUdOu4WYcwiukEMCokwDF4oR0ycP6EtJDolU2QVYcflW0MaQPyQPxFUlOp4oPtz4LDuwb+W59w2e5hGjOKbhLfZ7ZhiVYDZ9gIufOqRKAT9HeT2IhBVwRu/oaTPXNX927wqhzPigSw68rt74wdmj9tWuJ0QnvKSaVoZrMId2qSonshVgNmcslT1MI5gPqmb25qnKLQsLj587kDRrZQutToCJ93fmk9TP+AsdmeKrLkjIsGAfiVLMCR+1ey+mCh9XApO/l5M9h+6WpwKxcYAzx8ppMwxHLGYQKiJKDt1eD0WpzH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=RrwDvtAU8X8ob8/vYsjBn2YrIoFsDA3GAaoHWLZLTju4D66xHnU3etTNqVfGSF2zYeA3dkkwhTH/8ag671aX1SEO9rEeN8HMIAiXFxwMhjhjCUYqeNhUIbvYm48f24KXnfbdlooKurw0X0Xoy96idSTyj8d1+JbGD0MuE4kI9sQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8118.namprd04.prod.outlook.com (2603:10b6:5:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 11:13:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 11:13:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/19] btrfs: remove the submit_bio_start helpers
Thread-Topic: [PATCH 03/19] btrfs: remove the submit_bio_start helpers
Thread-Index: AQHY/N5PsUUuvCad40us6pz3ZV3jUq5gzeKA
Date:   Tue, 6 Dec 2022 11:13:48 +0000
Message-ID: <5f5260b8-00a3-67dc-862a-b67be7c2a6be@wdc.com>
References: <20221120124734.18634-1-hch@lst.de>
 <20221120124734.18634-4-hch@lst.de>
In-Reply-To: <20221120124734.18634-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8118:EE_
x-ms-office365-filtering-correlation-id: bbcd4c4c-2e24-466c-184c-08dad77af307
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFxR0z1lS1/48bBTHD5RcFvdT1JAFmgvx4/f6V414GO0NYBer0k+EK2VhoOc6JV+3jfDiilfMyDWuzWAUGR+l674YCI2EF5l1zkTQmHcWrzm6cG1vO2IAj1NySE47IPKbydym65eOPHAQQgd3XfN5XUW42oUO+Y4bU8ZBh3e4+ZG19Y3C/nEQ9aBgwbnqSSMZxpTeZCXnxE9FN0iFATVAkkwvKQSyMHFxPZm8/C3Vbb2yJdJojkDj1uqmapfW5xve7NnTbgsNNq7OCZ/MvBB89UCgu0cDkYEFDvnA8ABrvFockdLOgLQ5yey9C0GAG+F3wJ1eaQKf/BI1KVNvRh+rP47tLswf/EpodKJ3UufCM/uA309R2lWwhZpWC9u9Dy7IIdelvaSy3neU3+l1vDZhV7IRGr8yYrJ7QzzNxqbBGm8TaG3MofocK0B8jOi8MQxXYSAn2vJmEknct6yii8h6BDuZrreepANWdxM4ZTKDaIR6za7gmJERtd06It6qPhyDxJlPDxMf267j/9iEUip4NBAOnNanaKritV9bXWaM2rymU+q9nfgUdPslR7AxA9tsbb6SXGOf0oHABYW4zZWOFxz1FdzvWlZprwqb0rPL2COqdfWNx1yNOjHs2ORayOIlvKjLA8jLR3HNrGFnovF7vK+WG13wja2GaBQ0IM8NfCmrr5tiQazLqYM8wldtWHbxziCmlzqg8sw3KsmNQvT64ncfPxTT2t9eiacKxuWmY4ynybKFHDcHoK1PTnthNcZT6SInQEDCChDFp7VedRvFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(122000001)(558084003)(86362001)(31696002)(8936002)(82960400001)(5660300002)(38070700005)(7416002)(4326008)(2906002)(19618925003)(41300700001)(478600001)(8676002)(186003)(64756008)(6506007)(6512007)(110136005)(66946007)(2616005)(66556008)(66446008)(6486002)(91956017)(54906003)(4270600006)(316002)(76116006)(66476007)(38100700002)(71200400001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1VETU5URThOVnVkV2NIa2czVmordmVzTm9lQzIwenpFZStTRFhVZ200VWZn?=
 =?utf-8?B?SDAzNE1CMUttNktKNHVvOFk0ZEE3cVJXb055RnpxZlRseEJ3c3hIUnAxRVlZ?=
 =?utf-8?B?Qy9HeE9SSmxqVEhZRndsZGxMeVlqVnp0MWhCaVhCRTQ2TjNUZHhVUWdMbzZy?=
 =?utf-8?B?b2xJU1JWUWV3TUd5dXZaR2hXQmNqeTF1WnNKT0VKTHQxSng2WWlTMWVOMlJH?=
 =?utf-8?B?NmNvTndMb0tnejRLN3NzMlNPMlR6Z3lJa0NRc3BMUTFOS3Nab1psNmkzd1Zy?=
 =?utf-8?B?ZTR1Zzc3THBtSERPcnpKdHJoQXpHeVJyaERrdkdLcER6RXh3S1VXeitlSkZN?=
 =?utf-8?B?clliR2ZoMGkzbmFJRmwzZHRySVh2V3FkT0VtSjJCeDZiRkU3UXRYbEk2ZjJ3?=
 =?utf-8?B?WU5pRkt5NWlDQURwZkNQTkM0UHUzZXMrVHVybFpaaWtuMXA1bVhyZEEzUk5J?=
 =?utf-8?B?QVlYODBpZUZScGFLWGljQWY2UGFYSGozdVFndTdmcWFnMkUxUGVKREdnSW5a?=
 =?utf-8?B?V0kyMWJoK2tDZFZYTmI5ZEw0ZDRuZlkvNlUvRG5MQlJyemlHSE0zUlJNWGZq?=
 =?utf-8?B?UEtadFVXQkFSV3BRcGhDQXFDUUxMNXdZOHlCKzYvcTl6NTNvMENQL1hmK3Ew?=
 =?utf-8?B?VmVWcGt6VlVwT0lqUmhuSktBRDl4b2VOajhBd0lOOGNTT0lOMzFkeWloV0dE?=
 =?utf-8?B?VWp6QjZXUC9XMnpVQ1BVa2FQTWFVb3p6SUd1WStTZXllcWxhbDBKSGp0ZS9V?=
 =?utf-8?B?ODdDUk1CQ0ZDbGJsdUl6bDltU2FBNW5nUU52eVA1TFE5YndZNldzMTVYZU9K?=
 =?utf-8?B?dHMrK3JvMGtxK3d4bkhLVys2NkhSaVlaaC9DNDl2dm1YRG96M0FCdFVTRzRO?=
 =?utf-8?B?MnVjc3BLVGZ1cFNwQTRmcTNDeEJyMVlQWnZRcEhWRSswSXUwTUJMT0JxZy9C?=
 =?utf-8?B?ZDVjakJ0dkFFSDBuQVFnT3kyZlBWYi9ZZ0thSXlLU3FGcjc0M3NsV29VdXdX?=
 =?utf-8?B?Z3NhU0Y3TWpCR0dnRDRENHhXQlJ2M0hxbFFDd20xZ2t5NUZXR0tCVHkrY3JT?=
 =?utf-8?B?WXh2eTMvYWNqQmd0ZjdTZ2t2VmcrdFRRSVVrV3hveVpGTjBLOFUzLzhUdzdw?=
 =?utf-8?B?T25KeThrZlFiajlRMklmSWJxNVpRTnN3S2poOURrMlBmN2dxaFc3TjdzZ2oz?=
 =?utf-8?B?bDhNemU0WkN5SUE5cUxzQmovYnpqSkZMMFZPYVpjakNSR09HMTczZnlXVktG?=
 =?utf-8?B?eW5scEdyQitMQ3ZQTm4ya3NZbjdmTFRYRnpvNXp2c1BtNzFzNFY2NGJFZWtS?=
 =?utf-8?B?Wi9lWGxCbDhyekNkWTIrSUNMRWY1TVJDUkVYemJicnprWFAzVWtnZEdyWUc4?=
 =?utf-8?B?Z29ZRk1ZdmpuVWxKSWpCaE94My85SEFuSkorRGQyc3hSYzRxbkFkQ2tFTlVE?=
 =?utf-8?B?NGFTQXFPbzgyR01JK0RQbFFmQ2s0NXlqZEwrVmg2WWIxd0JHTzlTNExZZVRm?=
 =?utf-8?B?MkRYMDVKaVQrOFBVdzJlMjZaT1pnOWxmUFRXaUxpeGdYUnpCbVBMZ252eGV1?=
 =?utf-8?B?enBXdmJtWmJ4ZnJPOXR0Vm8zVW9CY1RkTmhXT3hFNU9wZDFsVHQ1dFhLc01w?=
 =?utf-8?B?aitLSUZSQTJIUHdaa0VvWWdYVkpDRTlvUS8va2Vrc29zVTlMRDJvUHhRMERD?=
 =?utf-8?B?d0pTYmhxUEtPNytwUitTaHAxdzNLMTduQ29yVXA3SDhyQlBxbExhYndBSGRy?=
 =?utf-8?B?STlRMDFTeWtQKzRQZkY0dDk5WlkyNy9Mb2RrTndOMVUyN3h4dXNPNVQ2bGFP?=
 =?utf-8?B?dDB6VCtkM2FxbzFpV3pFQk9GLzFlRUFsUDJnWHhaNlh4WUVCZUtORzMrdm5X?=
 =?utf-8?B?SUJrK2ZoMzNwbDBxWklFY3FrcCt4UERrbEgxL3o3elFSZWZDTCs3MHF6dGlU?=
 =?utf-8?B?bE9RREFIV1RWMTNOVEp4TlBwbVVRSVBjUndjdlZHMzBZdkFQT3dCN09NS3hX?=
 =?utf-8?B?ZVdOZWFjckwvV2tpSlIyemhJTUdoSUdOMEFvQnoyb1A1eHA0WGUvUldtMnBV?=
 =?utf-8?B?NWVQcDB4OUFRMG12VzRKNVpzSitHR090OWduQ0x3dld4YWgxMVhoRTA4WU1m?=
 =?utf-8?B?VFAxWTNSU3orOE1rVXcybHhlQTRnN1dmS3VxYmtrMzM2THJ2Wm4yOFkzeG9H?=
 =?utf-8?B?RU5DS2pSSjJ1UXhOVEtTUTBlbTgzMmF2ZUFaRDhXOHlRanhtZnJnNjRIdGRk?=
 =?utf-8?Q?c4u5nwd1224CFL9AmmvTBuEDevZsUaV5oA1t/DvLFc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D19B5C9485A86B45805885C9D1B2F56A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZHBZdW1xanlRblRGcTI0RHBUQ0pmTXhCc1JmMFBobVlhUlUxdUpvRVIxdUJ2?=
 =?utf-8?B?V0tCTWh0QkVhczEvSUxLWkF1ZEhuQUMxMVM5TVQxaEFka3pWVzFyQ0VDbjkx?=
 =?utf-8?B?YXBpOFJpTjJpNmtjOElFbjU2UndGQXpuY1Jza012ZVNGU0x1Mm9heE5nQ0cw?=
 =?utf-8?B?MFRLNEQ1cktYRC9hazUwaCtiNUVNK2RTZDV3MXlTRzM4aFp6YlN5bVJxZFk2?=
 =?utf-8?B?bWhHbkQ3aXJYMHFhTXZJMFh1bGlYN2k1VDdHcXFVQW5TKzlPRm5WR3FyNW9r?=
 =?utf-8?B?QnFHOE1nL1plYWhiZHgzRkFzam9qNTI3UGUwWkg0ZVB3aE54MzllOHBMZnRH?=
 =?utf-8?B?cE1NUE85bTR6d3R1ZElPaW9Cc2JJKzR6UlR5bHp2ei9qTmliOG9QQyt6c251?=
 =?utf-8?B?WFFBRjBRM3pMY0RlVWd2aGFCZ0NnNytnbmFEdEdka0pwM1FmeXpnayt0NXZE?=
 =?utf-8?B?QnFUZGowN0w3eGljQjNzOVUwdFhkOVU3QjBHZFRUZFlaRDJ0TDFDblNoNHdY?=
 =?utf-8?B?T2MzcUsxZzZycUxiU1RYT3lxL0VIOGt5dG9EMGcyVnF3cDhwZjFWV3NCcUFS?=
 =?utf-8?B?STFlZzZocmM0bkwvazdadEg2RkVGaDFuZ0tGaUl3S0hwcmlqWEp3OEN3RUxD?=
 =?utf-8?B?K1hwSWsxd1E1Z2d1UmtON3lDTTNKZkFQczloOWt4dzZJbVN6dkdXellLdzA1?=
 =?utf-8?B?eWV1QXhxaEo2SUo2S2tPNDRNVWwyUmNWYkF2czRMeXlxeCtDUFppekVsK1Fl?=
 =?utf-8?B?a1k1TTFpR3FVNkV5eE80dHAvQUwyMHYrNjloMkdJSW9pL2FzWDUxZDB1emV4?=
 =?utf-8?B?REtzU0FUaUlsVGlzYUhiRjJ5OTQ2UHhpd3UrY0puZjUxMHg3d25hVUZucmJJ?=
 =?utf-8?B?R1BvUllOUGU2Y0tCdllwTDJITlJ0U2tlL3lNWjd4cjdWcENMYkZCbHp3S1E4?=
 =?utf-8?B?YmVpbWpkZzkycGdoc0VuU1NNdy9SNCtHdnFsNXRsMzFxRkdjY0hRTE91emgy?=
 =?utf-8?B?OWwvWXpvUmFCdE0wNkw1d1MrclpnN1YzT1luR3JSaVBLWmg1aDFsSUt6SG51?=
 =?utf-8?B?czRmR0ExZndYanYyZ2pZSjZkdzY2NTA2MU9YQ0NmSE8yekJ3SkZxWEZybmg3?=
 =?utf-8?B?M0J4M05YQkdSQXIrUzJVYTdXZ3BsVWZoZGJ2WFJOVXRYZ2hoWG9WaE5ETXQz?=
 =?utf-8?B?N3VzcGtMY0dxbHN4OEcvUDJPZlFpblowTDhST1VmNEVPQUpGZlNZcmw5YWNI?=
 =?utf-8?B?akFPYkRNd3JHRUNON0VnOW9yR2VtMTdLQ2pTbHVKcEwrc0RrdnNkVWVETWtS?=
 =?utf-8?B?TTIxSHp3SmdNelpEdDNFcXJlRUhMTkErWC9WN1BJbVBqdGZTcGRXYUxGd3Nu?=
 =?utf-8?Q?PFrMmkMwdsY/ZW3iDQXQganouFrgNB0U=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcd4c4c-2e24-466c-184c-08dad77af307
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 11:13:48.9500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GuFN8G+/tPF7zgxcHYrwBF2hIzEIrhocwaIbWzXKyTU+VF4pdTQvzB6i4TbRHgunzIm9BjubDyhljADWWOFciiCOAgR/Vd65UyP0nQpfHbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8118
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQo=
