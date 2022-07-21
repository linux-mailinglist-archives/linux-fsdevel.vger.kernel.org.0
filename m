Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E444257CAD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 14:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiGUMng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 08:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiGUMne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:43:34 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E776F7BE18;
        Thu, 21 Jul 2022 05:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658407412; x=1689943412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SQnAcJoIo5oHAI0ZHoMIEKZDeQcHsSWptocF6lM6h/w=;
  b=wSfqaDL1swnxI65hLUA6Ryp/zqq+9Yl76qH+O7lR/5qvrLi5Z22ZcSZH
   RXx1HW2N1PAr7RUM1386dfx8Y0WE7X0tXKm5E06NLtLNCcX0V382J3/4s
   T0VUSnMXUPLb7dzYMDOrpfRr5uqm+HJHvSZgwLUVU/Vl+6XxzNc0tPXtE
   7MQz/POlmK9Nu4mV03zE04/xRoK4RDrvLrzr72OcBivV80+6nF7I0elUP
   ajeTCEhQ7vc4YB8H6MHLKgGlmv+cC69Mu5VwAc5Z9jF/hF70rMBgaHC62
   D29sGSroNCutMJOOpTz8JWzeKKFG+TuyP3u+yLtMbNPbRK8lCngKpDsbg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="60960949"
X-IronPort-AV: E=Sophos;i="5.92,289,1650898800"; 
   d="scan'208";a="60960949"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 21:43:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXnwVnm2WHVBgtrHsipcuJQQGAgGMh8KnHP6pyJ2oDw7U12gGa3LuJqG9R1AhrjcfPvL5piJODf/tfrT/jJI1YxDS9KS/A3W87FqVYy6Y9clo+LVi0PmvSmTxburdcKAQtKmSuzkFF/pz2701sDuazRVKp6S0TW7fRgocVmQYktxHpzYn6p8Zy6QIQ0V9vJzcxOnkR7yfXApPv15uxzmU5frC4P2eeCY2DyR9nuAHgblE4Upif539SBYFpkehU6260Fn7kXMlWxfizjz1fL+cPBuekBuuh5VGjXEQ00GUoDOv1phXqg5diIK4J7eovE0sBz5T2XHnZ/VJuDXOoE60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQnAcJoIo5oHAI0ZHoMIEKZDeQcHsSWptocF6lM6h/w=;
 b=XIfOCIZglRyuXMcEaEJuFD6HPolZLcqGwXvc1fFPv3eAZqbNawQYDGZJbS2VvMDqqI5Zez7/zu5OATK26IDVWnXhmSmN1ixLwvuQL6GvHqFpB8xQfYy791NrhzWOObGRgeHLXme9n/wQ1CBe4GCcoDcDxNOYEJzI5SLZp8oSg4N1HcQ1XLuKUu3jRwzRSnH0cgS1H3d1cQGb10EE31XwsN17imzcamqaDqQXfFYgX8U5o4puvYf5VsTyuTKBytogj5A4T2BNhqQXqnG8Aj1D125HMxaf257ca1oRnlno547AX9abyJd4cN+rklrPTkf7Pa+tSmiiTQBMpEt+6UYApg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB5927.jpnprd01.prod.outlook.com (2603:1096:604:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 12:43:25 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7556:cf54:e9e1:28ca]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7556:cf54:e9e1:28ca%7]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 12:43:25 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Thread-Topic: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Thread-Index: AQHYfA4g5aj+ViA5o0mdS5cU960Zpq1oy6eAgABPOICAH+nggA==
Date:   Thu, 21 Jul 2022 12:43:25 +0000
Message-ID: <bf57f3a0-4513-ef87-0f30-809d4276545b@fujitsu.com>
References: <20220609143435.393724-1-ruansy.fnst@fujitsu.com>
 <Yr5AV5HaleJXMmUm@magnolia>
 <07805923-6455-e046-8c0a-60ed99d1fb38@fujitsu.com>
In-Reply-To: <07805923-6455-e046-8c0a-60ed99d1fb38@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-07-21T12:43:24.755Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01e00b38-7b79-42b3-b0d2-08da6b169a7d
x-ms-traffictypediagnostic: OS3PR01MB5927:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D4XaNuXBCcw+ayUWG016YaG831oQqw5ze7bUslletrKAD3PyHoFmJc6QWq7d+9WR+VblDlz/e6IDp/QZt5R5V4JP+VHPBbbpR8SqoYV8wg5kHiPae0uhMQVvMnhWYQ4GXSfglyg1COhCRrqTjVMPEYk8x/rzbA0/MuI3CeXUawxSR+bVmWVkuTCbZvmS6F/EV/kXGJ0NCEVsLN+fXigtjgW4XEB1Ty9HDfKVaPjmdg5BGt66p6BZRsRBOz0aucVbruiFG3J6nQjLPMCiCRI3E1p2s0JwUGaG+CCbtekZ8FrHXG6XiiaBPn0cPa86Aq6rcJmwuEmy1bDYDr49Tbds5XLTZyFXbXx8QLQF74aaXhkksaOjV9ei7zw4MJpo0baOoRB4cucYzYHG0bmH9YuqaPFD1hgR/pUxEQa6uVjAB+sjoeNVKelCM9u33V5BCs3GNlZ6NSPXZN27Shg1CitUjG2U8TrGykyqoxmFda9iKXDu4XKw6czPH7Wkx3RrkxHGehUJaSuQ4+1+AYoPh/9SGkOJQFC2eQRqFVDWnxugjEWClGNEbcrxza4j+sby8O6U+HXH0D77YI266DG8WITUqwK5f8w11+cGGhYIulgcBatPNJH9O/VDGl18wIHYe985pHrNJIzU4gbtUjwsuxR+McMfnRj7kFqtJIYvqHs8VJFOIT2mkQo/igCQKXbGHPrla4+N0qEWaRoLDPhHnYnKov+G1KXPJzE/1IzLZJa3LkrN46cesFRha6Wi5nS+ai3lk7dG0QOjlBqVEQVmIIWG6eYEHSEnLQNxMc/MG7Y2VacB/hmV/5AlbyYOfj0bFGTpiXYCKN8xExDgnORgreZhFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(8936002)(66556008)(316002)(31686004)(71200400001)(85182001)(36756003)(2906002)(41300700001)(478600001)(6916009)(54906003)(5660300002)(6506007)(26005)(6512007)(6486002)(82960400001)(83380400001)(31696002)(2616005)(186003)(38070700005)(122000001)(76116006)(64756008)(66446008)(91956017)(66476007)(38100700002)(8676002)(86362001)(4326008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHg0M1dCN2F0NGFTaUovUFpEbGY0Z2J1S2RYQVdFWHlWM1JwV09sOVhqNG13?=
 =?utf-8?B?T0NRaUVCQlM3dW9YTEMvTE94Q1NEY3pCcSt1MU5oc0w3T3poVVJwY3dFMjA4?=
 =?utf-8?B?RitiRWYvdWowM3IyY0tXTG05L21sNklseGJCOGlvdlN3SkhrZ1JzMDJvbm13?=
 =?utf-8?B?QWtGc3p5ZkhET1BaWTNpNEk2Qk1Md2duVVBlUmNGeEc5NGhNeDhMcHI1azYw?=
 =?utf-8?B?cTlHSHJ1bktLMVhCWVFCWVNwYm9Ba0dmTHB0Z0IydjZ0V1kyZzBzU3p0bTcz?=
 =?utf-8?B?Y3ZwSm5xMVR0REgrRlJXSWVMNHZyTnh5bmxsc0xmWnRvRml6VCttTVB3YXdw?=
 =?utf-8?B?ZDFDQ1N3eVBZK2gyUGtGREtxaWVwSVVDajRSNlpPSnpLdU5neWROMUJXcTRQ?=
 =?utf-8?B?ZEJQNHE4YTNXUFNlbjAxdm9ORnI1Q2R4UUFhVmZMbFZDWGhPUzhXdVZOckN6?=
 =?utf-8?B?S29HVzBLczVtVHdTK0RZbUtNaXU1dkpzaXBSMWFuRXJVMFNZdHRScXdyWGsz?=
 =?utf-8?B?bGF1UzVxYlVBM1VwNWVsN1doVTNYTXVYS2pXa0hPVnpkSURrYWxjVDFqcmpD?=
 =?utf-8?B?VjVyVXVZUERpSHhqVXllUUZsd2JBUTVFUldYSi9Dby9wZmM5aHNqRWJSaWpt?=
 =?utf-8?B?VWNKeHVjNnZONThPL0dwR3VTYUhHZXlpaGd1R0JIQW9ML1o5WVR6NE1uaFhz?=
 =?utf-8?B?UmpnK1dXUDEreGNwUTMzU25GbnYyektBcWhFSlA2ell4RG1rZnlKRDJDajNR?=
 =?utf-8?B?ZytJUEtoRG1hRGhaNjRiR1VCeG1KUTFuenNFZU1CcHRuYkozYmRoWjZ3QW9I?=
 =?utf-8?B?MS9aT1pndjRJTFVnMndJUHZkY0h0TnVCYW9iRjQ5Ny81ZGtqOE5TKzNNQWR4?=
 =?utf-8?B?S2hINm5pWWJYWkw3cEU2U29OM1B5MThTK3V1OU9WNEVVNTYzc1YvSkFRY212?=
 =?utf-8?B?YkJ2SGgrTUJ5ZjloTktseTBzSHo3Nm9zMkFTSjMrYlZZS3RTM29RT0VjcjI4?=
 =?utf-8?B?dXdxZ0toZmJLZUllMXBGRzdPREMxMXZvNUQ0WUJRb1dPQ1BwNzRGWmJBdzdq?=
 =?utf-8?B?M3Y3dkRvMU9XZ3pEclcxbnZSOENUTi9wdW1SWUdpVzF4eU8ydmV6Z0tTaWkv?=
 =?utf-8?B?bksxRlYxckJnaGQ5alljLzV1VFFtdEJoRW9QdkNlVzVwT3REVWR3TlZRSmJT?=
 =?utf-8?B?WmV3K0NvWWltRmxOU1ZUbkdZczk2dko4N1dOazBZTlFoVVRac3lYSlBJMENq?=
 =?utf-8?B?V2FJYmlFbFJzdUJreDhJaHFnaCtoTGt0SWQxTHk1bGxlR0x1UFBQa2UzTHFC?=
 =?utf-8?B?bitudmxCeDJqMmJUMDBMU3BXUjcwcHNReWt0RXBGSGQzMjljVXRYSm9LeEIv?=
 =?utf-8?B?OE50WER5WkVRYUZNdHMyWGNHcm9ycVVTVnZaVkdhMmJJM3dQbmMrVW5LMm5N?=
 =?utf-8?B?TjFHTklBWkQxQkV1L3U3aERXTmlKWmk0Sm9GRUEyUWhjeFRoT044MlE5eDBL?=
 =?utf-8?B?Z3l1NndIeHN1UVdSMGRMVVJ4TzdZU2R0TXJoSWpnbjRQS3FFS1dDKzl4TDlh?=
 =?utf-8?B?YUVyTURYTXB5enRVTjF5U0J5RDhZTU9UQk9HOFFlNCs0aGNOdjNYS0lVanU1?=
 =?utf-8?B?SGVnL25PMkhmSXB1aElpdmlsc3hhc1ptK2tWNEpTOHF5cGROU3JBd3dRRDlr?=
 =?utf-8?B?QXcyaHd5UkFCMDRRN0Vpcm1WNmorSEwxb1l4TXpNUU9DQUlZZ1Q3WFZzQk8z?=
 =?utf-8?B?UDVQRldBeVZzVm1CbHB2eTI1UlRwNUcvV1IzMFVzYnpySThlSS9FSXRJTHpi?=
 =?utf-8?B?MkJEVGxFSyt4aXJFRFZSMHJvWHlyVHNLb1R3RURhZTFzcXpXMFYvRWZaTmVG?=
 =?utf-8?B?RTBIbGM5cDE1d01LVmN6VEY3Y3NqSjZQc2lDSzFobDVrcThRTTBSanREUjlH?=
 =?utf-8?B?L1R1NmQ3OFNUMHBpbDhpRTJLWUFUeTVKM0FqWW9KTGlqODZ1dU9yK2hNbXZl?=
 =?utf-8?B?Q0RJRGNrb0JuTGNlcUh0a3RaUy9sMDEvdWpqOFQ4TFhvdXlaRUpiQ3FTSEZl?=
 =?utf-8?B?dHB3NzBLWlJXZU83bzd1Rzh5ZVlBdGY2Q1QyS3RKQkRXbi9OaFErUTRrQmQx?=
 =?utf-8?Q?2oL+KuuqN876aBET6uGyINjAp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <477C223679A12B48AE5C72E74CD1B09D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e00b38-7b79-42b3-b0d2-08da6b169a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 12:43:25.1415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txUIfH7sLlu9tJPYqlCOLHWo2Gxvl5t046smnWxjHyYx/7DlolNCW7z3Iag2hgthIwRmOZY5DyYi/Wj8qrsqUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5927
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgQW5kcmV3LAoKSSBhbSBub3Qgc3VyZSBpZiB5b3UgaGFkIHNlZW4gdGhpcy4gIFNvIG1ha2Ug
YSBwaW5nLgoK5ZyoIDIwMjIvNy8xIDEzOjE0LCBTaGl5YW5nIFJ1YW4g5YaZ6YGTOgo+IAo+IAo+
IOWcqCAyMDIyLzcvMSA4OjMxLCBEYXJyaWNrIEouIFdvbmcg5YaZ6YGTOgo+PiBPbiBUaHUsIEp1
biAwOSwgMjAyMiBhdCAxMDozNDozNVBNICswODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6Cj4+PiBG
YWlsdXJlIG5vdGlmaWNhdGlvbiBpcyBub3Qgc3VwcG9ydGVkIG9uIHBhcnRpdGlvbnMuwqAgU28s
IHdoZW4gd2UgbW91bnQKPj4+IGEgcmVmbGluayBlbmFibGVkIHhmcyBvbiBhIHBhcnRpdGlvbiB3
aXRoIGRheCBvcHRpb24sIGxldCBpdCBmYWlsIHdpdGgKPj4+IC1FSU5WQUwgY29kZS4KPj4+Cj4+
PiBTaWduZWQtb2ZmLWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPgo+
Pgo+PiBMb29rcyBnb29kIHRvIG1lLCB0aG91Z2ggSSB0aGluayB0aGlzIHBhdGNoIGFwcGxpZXMg
dG8gLi4uIHdoZXJldmVyIGFsbAo+PiB0aG9zZSBybWFwK3JlZmxpbmsrZGF4IHBhdGNoZXMgd2Vu
dC7CoCBJIHRoaW5rIHRoYXQncyBha3BtJ3MgdHJlZSwgcmlnaHQ/Cj4gCj4gWWVzLCB0aGV5IGFy
ZSBpbiBoaXMgdHJlZSwgc3RpbGwgaW4gbW0tdW5zdGFibGUgbm93Lgo+IAo+Pgo+PiBJZGVhbGx5
IHRoaXMgd291bGQgZ28gaW4gdGhyb3VnaCB0aGVyZSB0byBrZWVwIHRoZSBwaWVjZXMgdG9nZXRo
ZXIsIGJ1dAo+PiBJIGRvbid0IG1pbmQgdG9zc2luZyB0aGlzIGluIGF0IHRoZSBlbmQgb2YgdGhl
IDUuMjAgbWVyZ2Ugd2luZG93IGlmIGFrcG0KPj4gaXMgdW53aWxsaW5nLgoKV2hhdCdzIHlvdXIg
b3BpbmlvbiBvbiB0aGlzPyAgSSBmb3VuZCB0aGF0IHRoZSBybWFwK3JlZmxpbmsrZGF4IHBhdGNo
ZXMgaGF2ZSBiZWVuIG1lcmdlZCBpbnRvIG1tLXN0YWJsZSwgIHNvIG1heWJlIGl0J3MgYSBiaXQg
bGF0ZSB0byBtZXJnZSB0aGlzIG9uZS4gICggSSdtIG5vdCBwdXNoaW5nLCBqdXN0IHRvIGtub3cg
dGhlIHNpdHVhdGlvbi4gKQoKCi0tClRoYW5rcywKUnVhbi4gCgo+IAo+IEJvdGggYXJlIGZpbmUg
dG8gbWUuwqAgVGhhbmtzIQo+IAo+IAo+IC0tIAo+IFJ1YW4uCj4gCj4+Cj4+IFJldmlld2VkLWJ5
OiBEYXJyaWNrIEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPgo+Pgo+PiAtLUQKPj4KPj4+IC0t
LQo+Pj4gwqAgZnMveGZzL3hmc19zdXBlci5jIHwgNiArKysrLS0KPj4+IMKgIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBh
L2ZzL3hmcy94ZnNfc3VwZXIuYyBiL2ZzL3hmcy94ZnNfc3VwZXIuYwo+Pj4gaW5kZXggODQ5NWVm
MDc2ZmZjLi5hM2MyMjE4NDFmYTYgMTAwNjQ0Cj4+PiAtLS0gYS9mcy94ZnMveGZzX3N1cGVyLmMK
Pj4+ICsrKyBiL2ZzL3hmcy94ZnNfc3VwZXIuYwo+Pj4gQEAgLTM0OCw4ICszNDgsMTAgQEAgeGZz
X3NldHVwX2RheF9hbHdheXMoCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBkaXNhYmxlX2Rh
eDsKPj4+IMKgwqDCoMKgwqAgfQo+Pj4gLcKgwqDCoCBpZiAoeGZzX2hhc19yZWZsaW5rKG1wKSkg
ewo+Pj4gLcKgwqDCoMKgwqDCoMKgIHhmc19hbGVydChtcCwgIkRBWCBhbmQgcmVmbGluayBjYW5u
b3QgYmUgdXNlZCB0b2dldGhlciEiKTsKPj4+ICvCoMKgwqAgaWYgKHhmc19oYXNfcmVmbGluayht
cCkgJiYKPj4+ICvCoMKgwqDCoMKgwqDCoCBiZGV2X2lzX3BhcnRpdGlvbihtcC0+bV9kZGV2X3Rh
cmdwLT5idF9iZGV2KSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHhmc19hbGVydChtcCwKPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICJEQVggYW5kIHJlZmxpbmsgY2Fubm90IHdvcmsgd2l0aCBt
dWx0aS1wYXJ0aXRpb25zISIpOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFM
Owo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiAtLSAKPj4+IDIuMzYuMQo+Pj4KPj4+Cj4+Pgo+IAo+IAo+
IAo=
