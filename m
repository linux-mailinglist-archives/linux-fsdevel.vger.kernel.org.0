Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FDA746C7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 10:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjGDI5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 04:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGDI46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:56:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A85115;
        Tue,  4 Jul 2023 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688461018; x=1719997018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=FoLk/qZkN1Uuqpw/gCX6AYcbQwpIVKm949KAnhewP38cMVCxRr22Tp5P
   1qZbNxNR+clb9crbuEfa0CfUtd9Eaqt5KOvQ5fRMPbALDMwNuyZ3svgmy
   lu/iSuHF1UxTKXEyBDxP2dJg/ztvW32xmDLGZzhbGGSPkRU0kGWCwIlVq
   bxpCaRNEJirfnPJajCQDn014FKkZufBEdOKQreuLBzI/CYjfcoYRmOZPX
   YB0GIZBJ/Y969zU8N2t9gGa+k1FJ+CjwDz0txNqXs1TBorjNrDGukmEUL
   1m1DuFlg6BEjDip1rcJfy+hNmAKFaCVytDzYZLThOjucHq/5M+D5iDrSO
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,180,1684771200"; 
   d="scan'208";a="236879601"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2023 16:56:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnGOGO7UxOZ20rIS9zBfFLkvCnAU3BD6XlTD6grbj3xiI9mlFAvBPOL8k61VGKWpYvPS3JfNXJnYJ7POITeOa8Ykxcbo/kIV1HW0R9MWnvTgMjpOVEC5OPyZITBwUpCygmc59+g7A/bjxDBPDeCklRJsf/jdRtZ61KH8oEYzdY0PE/B5juQEMUxY029yqUm/Mawwovk3/L5J5AEzqnWRvYw6bPWvpCnEgwzdnKmObFkM+DMYT5vTv4WE/Nou9bKVa5UjF1cTtS4hLLQhyuQMgU/xSD1r0gazwy2/YxwfYpJbl3I3n+0cLkSc06zfQcqnQgX6C2rAExA75W7w5E8xhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CwkH07vrt3GpCBUrPVupnQ1vFuGp9Rx/5SA8t5fmaBsll5kALoco6hYTgHYRw1lPwpUvZRkPOa+FAQjA1ZV6pW7XRouGBlwk60tVUcWlyMx5I0RfQu8q4TONVzLYhANpvRO4w8COi6olmuqhnE9/z07KQokmSNASAhJWYMPC7l2zDcb4CEsP9DaGhls99vMeA2w/gOUIvVTEr6re6qixCRIowbq2EtfJGFOvGOYiKW17aDyoEWwHtr61TJ+trUImZOCw74kcfwlytMRFv0GEPFun3edSrg5o6geU35ZoTLnZOTQVLQCUy8J7Jx9SUZMirflqKCLtCy46Gf6O610ocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=b69TOrQ+2CFaeY1PSf3voafPGsgyStGvHOBR1GSS4XgKE+vWjnZsDZ+qO216OWaL+y7ISE14EQwC/B6OcT0OZmLtnp8dG/br7I7w56Aoq1tYe4Wsl1GtPnsbIJTR5vaLzYrHADbMYZJdBgdcx3n8ax9ebkytNC+7LwEdVKjvqAg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6580.namprd04.prod.outlook.com (2603:10b6:208:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:56:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:56:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 08/23] btrfs: remove the return value from
 extent_write_locked_range
Thread-Topic: [PATCH 08/23] btrfs: remove the return value from
 extent_write_locked_range
Thread-Index: AQHZqdYCH4P6uZ3Ma0K/31BAPrrQiq+pV0qA
Date:   Tue, 4 Jul 2023 08:56:55 +0000
Message-ID: <30e6aac4-218a-bfba-02d2-de202513f2cc@wdc.com>
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-9-hch@lst.de>
In-Reply-To: <20230628153144.22834-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6580:EE_
x-ms-office365-filtering-correlation-id: 7d4647db-9156-4cd9-db85-08db7c6c9e74
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uoN1KO1/vjsNVt7lp3koihHUocpFFqGGZoXFqvmjGIJWJyLTZdoaRs0A4MVpQgFzs5ofX2aqUPS9Z9bYZa6+JKFhUh3JRB3mdUlB0Sk/5Yc1esTJZzkm0z2EDZmjOsjwQCIbFc4cL9a+yxauBcDW7VvH9SvXgPPAzmZQ8Yb6exfE1PGsmX92JKeogWZ0uiXJk7/nbeNKSZ4ufWl4ercZXwDddp2aXeVwj4mOnq2Ev2RBmCOZ/iUxtupQHwOVk9ZW0q1z/Cr14IcLjglGk74FyOPcT3vz7oeNb8EPtgXVxFTXRMUoOipIkC0zzEM3JZclCVp87ot82DtadTCPpcTDG2hQF4MwTD6w/MEJC17nfNv+5MLyswCmN7jzQIcTPgd0chhsSkBQGsIrArnnJSObYLRAZ9gUJUtQBLfv9+0wjjZoluaTyj4KNK33O4BHbN9NqNLWH2JLBiK9vN0RrOWlAIdrF9wozrWF8UKpdo5n1iD73+1k9JDj/TLBqSdssfAPKGDPcgwYUbK+ecPaKtuP+dxQpi5Ojme4dT0CXV6KBZhaNRTzWmIEirF0XEZT+MscHl/i5uLRD/ELjNIPw4Jaume2KOHlWhfTL64vqueo0Gs6eUZAHuYEfEc6qA8yKNJ1PtCz8YcjNH+pm/U02lNYeCROO9+67vYQm0J3djqkTJWcWRs040tZ0j905FkAg2Tt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(66446008)(64756008)(66476007)(316002)(66556008)(110136005)(8676002)(41300700001)(19618925003)(76116006)(54906003)(91956017)(4326008)(82960400001)(8936002)(66946007)(38100700002)(122000001)(38070700005)(6506007)(478600001)(31686004)(5660300002)(6512007)(186003)(6486002)(71200400001)(558084003)(31696002)(4270600006)(86362001)(36756003)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1VBcnRFVXRRU0RmTW8zbzNHVWtMQTVYZndJOEY0emNoTkpBZ0tWNjgyRVNu?=
 =?utf-8?B?OEliWkdyUHJRMi9ldy9uN1B2dFp6QjhiOU1xRkFxZmJBb3pwYUxtMUlyR0Nk?=
 =?utf-8?B?bE91SmUxZDVrMHVCSW1mQWQza3Y0MDZBdlIzRGVValg2MWNiN3Zad1dWRUV6?=
 =?utf-8?B?NndmYVBDSDMxcEpFRDRWdFNtUENtazhaMThEUUwvcmVHZzNYT0FZRnJTbDcy?=
 =?utf-8?B?UStKb1FEOGFLV3dJdytqNEJpY0UrWElOdk11azQzT0ZCS1p6TmdHUTR1cHZW?=
 =?utf-8?B?dVE3anI0ODY3blNGcFpXNXMvL0Q3ZHZvMDZtL2I5R1lXWnF2RUdvQWFEL0o0?=
 =?utf-8?B?Uks2Q0IySmFWeXBWcitOL2pRMzZVUHlXaVU1LzROWVR2UVAwWnU3bzdNKzZ5?=
 =?utf-8?B?dzlHTm82Z1UzUVFtckdFU25nMVRNbWE4OTgrdEhYUy9vRGxLcVpPR3JiVWtX?=
 =?utf-8?B?VVVDWC9wVXhMcThLNk5QcFNjVis3Q21uSFV2c1ZFOVF2Z2IwQnBNMmNKNFIr?=
 =?utf-8?B?NjBLVzFYVVhVNWhzVXhVODNUR2VmTjk3MHp2T0pNQkRJdW9CQ1lIVzYxVHQ0?=
 =?utf-8?B?RTZHMkxkc3FUUlljZ1Y5UzRxZy84SGtUT1M3VE5pYWVmV2JuejJXUm9LNjhN?=
 =?utf-8?B?emc2ZlhpODhFY2tzVzNhWHF1SDBlcERSUElzeXhOblgrcStIYUF4RVNxeEMy?=
 =?utf-8?B?LzJCRlFZR1cwSGdGYnhEQzRZUUtqRjkrWjFkV3BzL0RrVWFPa3JDM2FvaGNh?=
 =?utf-8?B?Z21yeDl6ZFd0SWJiVEphKzdpTW1PUEZZaWFEdy9SUnAzRWh5WkNYUW53T3Iw?=
 =?utf-8?B?RURZSUJFcGI0QU1Wd2MwbllINzZEQTdjWVJTLzVMSS9QSCs1VExRR3hJRzJo?=
 =?utf-8?B?WVlVejdoaDB3c1hZOHpqTEg5c1g1OFBlMk9yamo1VUtwRU01VEZraGV1ZnpL?=
 =?utf-8?B?SnlpNU80dGl2NC9jdGQwdVJ5Yld5c1lyZUFBY2Z3NmVpaU9SUytuOXJTd3ZJ?=
 =?utf-8?B?UW1DVlFXeXUwTmxGLzlteXhFdzdTb29FNE1tTUNKakFBU2lTR1p5NE1nZDBz?=
 =?utf-8?B?Tml6SktrNlk3eTlXeWhTQWpSais2dktzOEVBTFhBZFoxdVlqWVlNTGJzVnVk?=
 =?utf-8?B?OTVmVVFUTWJJY09iSGUxTVdZbGJKUnJIdVhJb0liZkdtV1RjaDVQTWcyRURn?=
 =?utf-8?B?RFBMN1hudzZNMXZublVVSVhVOHMzSjNJbGdGdnkrVndKM2VXY1huY3BiVFpT?=
 =?utf-8?B?UUlVejBPTkZvR1l3aW9vSmozOG90cTBuUVpvTXU3c3ZzRjRxVWdMV2cxNWo0?=
 =?utf-8?B?TnZHZE0rTDRxMGZKQUd0Y3J0b3BQbEthaHlBdDdEZkVYKytSSU05NTR4U3ds?=
 =?utf-8?B?d1o3bUNLaVNTOGE0Q3FOWnRDNVpYWE9OYm5XZm9lR2dxSGxUSkc3M1ZVbmVT?=
 =?utf-8?B?SDI3dklxdWNUdVFqZ0Z6VFZZdTZlK0tNelVScUcrR2Q4NkFIa1lJdE5iN1cr?=
 =?utf-8?B?bTZxNUZLd0VzU3N2Kzg1b296L0pVRDN1ZHN3Wk9EaTJUR1B4YjZ1V1hGS3pl?=
 =?utf-8?B?bUpkMzl3TEJLY3FGa0VQYkcwRlBjRUprRU1FQ3BhZ2psQXEvM2gzRUtlV2F6?=
 =?utf-8?B?a2VPcmlqT21lL2pkbktEeEZ0NElFVk9MN3d0akdLaEIzNkU3djFudVlncmdX?=
 =?utf-8?B?YkoyUGhhSlhDQUF1SklXVmZ2WlZSdmtRTVRGQnJPQzdESGROVDYyRFpMQUxH?=
 =?utf-8?B?b0hYczVGZmtlRHR1TWc3Vno0Q1RsQzVUMkdWQ3JEcXBEL01HdGViaUJwYnh2?=
 =?utf-8?B?Q0dxMytQU3Z5YS9iTkpVUGk1c1ZabWFDTnhFdFE1YnZsbUlwYzloRGhDTGtx?=
 =?utf-8?B?ODM4TjRCQ0U0TWJlZzBxOHpmNFZXTGQzNmlUcHEzRmdQcDFuMEM2Y0s0VU5Z?=
 =?utf-8?B?NFlGa1FKZm8vdy9rbHRqbFl2dk1ySGlvWjRJYWpCUnVFTGFuNEhlQWtWQ2hx?=
 =?utf-8?B?Qkw1eFdJSHlHdFJSd3J6NlJTb0RFdm03WVNUTGRoVUozcWMwOFN4dHQxVkxj?=
 =?utf-8?B?NkR3a2k4WThjZWVadDFMaDgrU1NmSXFRSHZjYjRxSHp3K1NMdVRZdG1FRGJL?=
 =?utf-8?B?QzBOYWxCaU40RFRkNnZkUjVPTWtVaGh0ZTZtVzBqTytVR3lBMDhzejU0UHpL?=
 =?utf-8?B?Z2I4dTBHRUZUMmZ6dnVyMktGTEFLU2czZU83MndGTC81bkhXQ3NHSEh2UE9n?=
 =?utf-8?B?MXhGVGJINy9sdUZvUnhJV2FqTG93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D56AFE81566D52429B27552CA4612E61@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MwE0wInKeSLiNKou4/+zR0qCjPtlEaToJQ9hk2iNDbfxl9ss1nMElFKom0k2+/3zs5XHVsRNdg1zRz94b0qOlihjcOHI34hdbpI7sODMwVNBFPwotCLEXu/ejE+9gRGRjTJ3jejWSP3AmxShDMt+5Drse9yWa/wEDHulYHTOzFRAngvh0KtNTMQzIrc1SFAnZyZYvaAIAF+74TCfFWkCQei/flbLlznLMA6wEhwwAvSVPUVtYVJK/+KjEn33eGUkmgRbuq7iCqTUhoyXOGA6h7aYmbI16iOmqif13mRI5i+nCnYx/AtSBG4VtYr0XipauPXNE5J2fg1/Q3PbxLN94s0VVhfmR2yGijkYZzLVWWXAHstf0tfFNImC8j00osFCc8nLzlCX/bWMgGOZtVCZVRiREqqnNMEA53TEtNgw/iuwJ8VVDsNyPE9Xwaxras6tqg5LpXFbvi3Lr1IINHa7niZ8fQPyhLvuIXxMQDGSSvOJJ+ZbqMEUXhGcRLHhhFNmJyaP8DfWcI0PNJ8kc2aSwt0aemD7wfxY+P5HdqouHfAClMTsH/JqVuOYjn6N5dLGVsgnhe4UuLCCKtVEzzd5oOGeQyKoYfGDhg6kyR+S6hBMI+zgvbDVX+q4RXvvWVDTdnP8rpek/FY/k/e+wyTUWXo+FhpC71MedJ6tZTOzWJALTDznZQ8DELK1CNLz7plO798Khbz3zDC90sup5JPOKLL7pmQRQ3CpQaCjyvgJwNvljA+5ffKNZFKultJD7bmht3MMlZUPNAL0KsBjYL7P36I1DNkLsOUBKHFDxUy0pBgOZ6DoutTH6hye4/78FJe8UdUly0h+T86Pc9PUKHJuJg90xQ2RUdoA8wWaIXk4enoXAVml3l02H+sUkQS2mrcWba1ex3ZZGOWDBMtHjrI4kmSZpnD7+95am5s32QTPKm8=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4647db-9156-4cd9-db85-08db7c6c9e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 08:56:55.9575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e14HU69b1zuN6E2cM17U5kGrBby01cZExCrWXe1O/rfWy8ba+C/dGGygrEF2ozmhFfLORBcFECwldva19lw9TOWWnIMts163asEVMYaxV1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6580
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
