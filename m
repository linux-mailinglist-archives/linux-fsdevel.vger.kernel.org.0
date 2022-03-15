Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E773B4DA39D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 20:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbiCOUAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 16:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiCOUAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:00:32 -0400
X-Greylist: delayed 1695 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Mar 2022 12:59:19 PDT
Received: from mx0a-003b2802.pphosted.com (mx0a-003b2802.pphosted.com [205.220.168.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79D15676F;
        Tue, 15 Mar 2022 12:59:19 -0700 (PDT)
Received: from pps.filterd (m0278964.ppops.net [127.0.0.1])
        by mx0a-003b2802.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FIHZwg017229;
        Tue, 15 Mar 2022 13:04:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2IPT43bqgJEZuhG0++rW9DybeX2zSkAV122DQESG6hk=;
 b=Ka1WM+J5kpbFKBAp17P0DnXO4qL5YWeDxvxcGPG13nWeSHeP9SIOEvyzsZfzAstat64Z
 2/QTcOW5S8pIQPNSOIR5NiXNvs3AuXdSYLmWeIRfxbkRctY4pmVRV4tgWJttu35M0Tom
 Sl/t3+glzK5OMwciHhdWBys8aEW5R0JOmPXHZX4cZVNmbF+xjFNsgly+PuR0FPkf/jTw
 LsqigVDOzjl2rG+uPkuXhzX7FT22US2yeXZPB2w5feLw1VvGHWnIF8j7sayhIOSK+05o
 +MupDH1qVFGCcMehp+CSPsusQSs+63TQBwv6Q1KCdd+FGGEEYa1F/k6G+Z1h0ffRfAjb 8A== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-003b2802.pphosted.com (PPS) with ESMTPS id 3et63w3ce1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 13:04:15 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2AdnQSasD+6R5g6vr3flf4VjmJsG7lg34Fk96lJfO1QYm5tBbgHqoa8av4aSltx0TT2V3yidQCPyOgdK2oe7T9EF6krnZeeQEg1H+iSzOsTStJQ8J9Qw/p6ExadCbij6Q+Cn0TnhOjaL96dniUA20fJYThJ8A4fqAIlw+JGh//XBvgiSbKp4fIrq5xNly6K9a4bQKMCbNYCbpk+2BVhamhS2gdS9Sxm9adlT2V1aHIrviQCpDhCTb0melHlVYamKwI0gfTLfD+5hMm0A0YLt9nkPZmxCA0J3NnwHDpE41Jg1p7PzpYemoQA6UhVirQDNvtW266QF+8SNG1yQVNhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IPT43bqgJEZuhG0++rW9DybeX2zSkAV122DQESG6hk=;
 b=QEMN1BJfWRVbrFXkMli4++a9wfpr1rSZU9MXAR469bKfY4i1nnbCmDgoXAB0PHYfWTyHvVjjJ9AoStVSDpoJyRuVGyMb4qdHCFub0j7spryOVaW3jgoS7yGxP78icxL7QcGQjB8CoUvCR3bgycCaSpRptQswUlk5JcZC1CJ3gEohX4MGMgTn1vcKDwqDz+i7KKcm0jObPjMpb/HG/IcH/+Yx2mCHhNXheoSRAHJB9lWr4gmc5+aN2LA6B5NAatpVsFiK176jUnJvKga/ZF5Dvomz9HbctPLnEL7LcEUzBDECHoaARabSpr89glNtDh+eSyrv3eAOfBm1zdu0TwW9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
Received: from PH0PR08MB7889.namprd08.prod.outlook.com (2603:10b6:510:114::11)
 by PH0PR08MB7178.namprd08.prod.outlook.com (2603:10b6:510:78::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 19:04:12 +0000
Received: from PH0PR08MB7889.namprd08.prod.outlook.com
 ([fe80::486:49b8:9b7d:31a4]) by PH0PR08MB7889.namprd08.prod.outlook.com
 ([fe80::486:49b8:9b7d:31a4%9]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 19:04:12 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: RE: [EXT] [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [EXT] [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpnaM/oGinGMOEqzg/qq41aU3KzA0iCAgAAI0oCAAADIsIAAAdsAgAACLvA=
Date:   Tue, 15 Mar 2022 19:04:12 +0000
Message-ID: <PH0PR08MB7889314A7E3C8FEC1E7A491CDB109@PH0PR08MB7889.namprd08.prod.outlook.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <CO3PR08MB7975BCC4FF096DD6190DEF5DDC109@CO3PR08MB7975.namprd08.prod.outlook.com>
 <73adf81b-0bca-324e-9f4f-478171a1f617@acm.org>
 <PH0PR08MB7889A1EB0A223630E8747A53DB109@PH0PR08MB7889.namprd08.prod.outlook.com>
 <4cfa6143-3082-52ee-6d6d-b127457ac2e4@kernel.dk>
In-Reply-To: <4cfa6143-3082-52ee-6d6d-b127457ac2e4@kernel.dk>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Enabled=true;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SetDate=2022-03-15T18:57:45Z;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Method=Privileged;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Name=Public;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ActionId=de43e3ae-e2ae-4237-ab56-d3d0d690162d;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b3a152d-df22-4461-2685-08da06b697bd
x-ms-traffictypediagnostic: PH0PR08MB7178:EE_
x-microsoft-antispam-prvs: <PH0PR08MB717849AB345E4F6544F44F32DB109@PH0PR08MB7178.namprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Pqa6s4LkCc2k2HdNyMYmgC/jLnxzrAUCnUx2UHGEYKeobPWTbek6P104aYAgBHZcgf9fIqylK7ifbFmU6uTQPkYgJU68IBDoSJ9GZGbkrncZqfPpuhRwHFyfznBT89D3KF1kRGVtI6hi5D5R/TSzfePiiSqPQEkFYEB/K71+r649u1jDnxRrcsGLWv4EB73+OgL17WtkrTokswhXxpO1i/RLm6TW4WCo3TFJQL6lPKo/DVHJVE9NUBA0RHuuvaTuDzOrjRL0hwe+7+lfd8vE/nsBAWiKkCEMIKlcbhxyEhBlpOov0b9Al3xTzt+Izo0RtsWDX/99QyFtnziPVpMxIk41dxVcNLq0IYB+ARaGf+vxaB0mtSfOSVhZz8M+7dvQG6qanafp5jW+UfqGvJOx4TvFqgWocVoIGxDX8bO0VaXpkmocleX5ktXxZlkG//4tg91Xf0roEUXHaT+B0jKkGx3/692pSycbkUA7Mnm2G+SIyftQevDOI9h/OtWwqilJ9ZIjlh8Grol9GX6vcDAlHLxZsPAaLd7r7G8haT4ma9FguaRiidzgToEN7+w07+NKIFx9VRt3MB6wx3NMxpFIxhHZSx4vvvX1RGqDYBd3vs47IarU652PKWpu4RQkDROa54YBx+sSkz0E3+YTu68MH6sczWA3jSpNgRSufBrGh/Qj6aEdFHtzjPjthKk2aWJTbB1A/QHLVVCpybgW2isVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR08MB7889.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(2906002)(52536014)(66574015)(7416002)(45080400002)(9686003)(33656002)(83380400001)(508600001)(54906003)(8936002)(7696005)(6506007)(186003)(5660300002)(8676002)(66946007)(66476007)(76116006)(66446008)(66556008)(64756008)(86362001)(71200400001)(110136005)(55016003)(38070700005)(122000001)(316002)(4326008)(26005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1RhOW85UGxPNldOdk9VWThyR3Jneno4ZlFGWkNNcHRQeGhlUTA0c1lBT1o4?=
 =?utf-8?B?ZlR5RzNuMlhFZm91SklHMHBURnZQQVNxSUVJRHhTUzNPdm8xZSt0ZGhmMkFr?=
 =?utf-8?B?WnQ1MkJ0R0NVM1hWTXozUEg5U3laOW00NVQwazQvRmE5bkNSNEY5RUo0SVJx?=
 =?utf-8?B?Z1hxeWJhYmpHVDllaEF4STdERjVNcmsrSXl6OUFmSURKaS9zSm1KYm4vTlVk?=
 =?utf-8?B?M1g2SnRMaCtJTTU4ZEJJcWpuMUZsYStBZXdGeTV0ZDdjd1V3dmxXeFYzdDlP?=
 =?utf-8?B?dyttcVhwSWlnQUlEbHU4bS9DVkM0dmE3SURjUmgzeE44eFROQ3ljVDZNUHg4?=
 =?utf-8?B?V3FlWk0vR3VkUHpUdCtodEM5QS9aVmJpYmRKSnArUitxVzVXU29lUHpDVjB5?=
 =?utf-8?B?SWhlcVpxWkhxamlHSmxOY3lXOHpCeGpmUVE0azl1MHB5ejhzRndkWTNndTEz?=
 =?utf-8?B?OFZzOVZSTUZWd1UyaldZWGlhbGVsYTJwVzFMN1RpUTlYVUJMOE5BdmNNOERP?=
 =?utf-8?B?K1VqL1pCL1lWaXJYTmV3b3REQ01lWVBOK09CMXJUd1Fvb2NZN21xMkFiOEJ3?=
 =?utf-8?B?TGllWWNBM1Q2L2o5RVN1UjZ2T1F1dGdNOFV4amtGcktEenlHWVJ5RG5tdUlS?=
 =?utf-8?B?cXlXc3dScjJrbCtsU25TSVpiTWdzQTIzcUgwNG90ZHNBRjBYRGU3QzhaREho?=
 =?utf-8?B?ZGpqUWZvc20zUFhDeEorQUJIbWR6cjlyeTRxQVJKZlN3ZkRzZXVrcmc5d1dt?=
 =?utf-8?B?cis1MXZoZ25mamZneGVGV0xlSGplUE1pUDk2MVJwdE5mNmZLMVliRWtLRjZ6?=
 =?utf-8?B?S0pFMmlYVkNyZ3ZmcU1VaThVUGxtVmEveXFWVWUvSDZ6MDBDQWF1a2Q1cDJo?=
 =?utf-8?B?RUpIOHFEOFhjOXpzemZQVzFPYmh2bGVSMXd6SWMvVEI3VlJMWkRtd0dkcXNQ?=
 =?utf-8?B?TnE0b1hBWFFXYUpvZnkwaUlabk50WmwvbFNSZnc2eUcvUG1mSkIxa1ZOaGg2?=
 =?utf-8?B?UWtKbkkrYTJBeFRyTWhYbjdmL2g4ZnZwUGRhckJKa3JncEExditGaWxqOHNh?=
 =?utf-8?B?V1hBVXFVOTVpcHlXRUdyZTdYeVVJVjJtV0xNOG4vK29pSWIxWWlER0UwQXpH?=
 =?utf-8?B?TGRwcmlpNm5lTXRyKzI3cXcycDVlakYyTG1MVjRDMTNzN2cyd2ZUdE42SHk3?=
 =?utf-8?B?aWpKSkRWRnh1OWZyeTNnRkFwc01RQzFJdUsvOXJ1MzV1S2VaZHVlUExMQ0RP?=
 =?utf-8?B?WWoyem1wQ1ZzeHlQZy9EUEJLREpndHN1eEZRWHZrM1V4TUZOdHhkajRhdC9n?=
 =?utf-8?B?aktnY2orMDFRSUhRenFRZGkzNG1FRUVNWHJuZVVLL1VTWTdXekcyai9Td2Q3?=
 =?utf-8?B?WnVNM1ZTVEFhRGpCNmpXODJWRXVqRWpnQTlsdGRwUWNFN05EQ1ZKbGxIZ1FH?=
 =?utf-8?B?eGFCSTZ5ZjVYUXRmVFdvTUhjb01KVkxmeGtNNjFaS0wwYzJRdlR6WVUxQWtR?=
 =?utf-8?B?ei92SGd1OXowdGZZT1h0UVN6Wjd2NHUxYmZmNEpscFkzNzdjOHNRZVZQNTRm?=
 =?utf-8?B?QVVDLzlXM1dNdjE2RVZvSDNERTUvcHUzNlZ0b3FqWHlRZ3RGT1Z3dmhmMHJp?=
 =?utf-8?B?RGQ5TFdudGNYNEUwbEVGcU1IQU9FS3ZHMlNuY1V0Sit1amdhYWg4cEZxNS9r?=
 =?utf-8?B?Ti9sanFnNTlxUFo1L3FtK25lbjB1aXRHbXRoQ1gwNVFBclVsWUZFcGVHN3Fo?=
 =?utf-8?B?c2hkckwyNUkvNzJOWGNUTEFuSEUvaVNHUERnYXpWb2pCc2Z2cHlDYnJKQkZX?=
 =?utf-8?B?bVNjL0o3eFpNUnJyZlZpaG9KcldIQStGaDErdE5HQlkxLzhoajJXV3FEU1VS?=
 =?utf-8?B?V3YvYi9qTlJ6cmU2U2JPUWgyQ1VYMDV4bW5meGNYQnFUZVovRG1UZ2laTlVZ?=
 =?utf-8?Q?S5w0g7CucDBXZ+CUa4JsSCB/6GBK/SuQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB7889.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3a152d-df22-4461-2685-08da06b697bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 19:04:12.5079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yAX7YLBGRCIoy1q0WMguA/r8DZ4qDzmAXdoyZ3RL5LKoJX5yfdiZZ0OlQhO2+Ht15Pnwsmxxw/bOrMCny7Gsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7178
X-Proofpoint-GUID: IfnCIgA6UnYzCp0Ii4fo5Ffqws8mOfR1
X-Proofpoint-ORIG-GUID: IfnCIgA6UnYzCp0Ii4fo5Ffqws8mOfR1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBr
ZXJuZWwuZGs+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDE1LCAyMDIyIDc6NDkgUE0NCj4gVG86
IEJlYW4gSHVvIChiZWFuaHVvKSA8YmVhbmh1b0BtaWNyb24uY29tPjsgQmFydCBWYW4gQXNzY2hl
DQo+IDxidmFuYXNzY2hlQGFjbS5vcmc+OyBMdWNhIFBvcnppbyAobHBvcnppbykgPGxwb3J6aW9A
bWljcm9uLmNvbT47IEx1aXMNCj4gQ2hhbWJlcmxhaW4gPG1jZ3JvZkBrZXJuZWwub3JnPjsgbGlu
dXgtYmxvY2tAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZnNkZXZlbEB2Z2VyLmtlcm5lbC5v
cmc7IGxzZi1wY0BsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KPiBDYzogTWF0aWFzIEJqw7hy
bGluZyA8TWF0aWFzLkJqb3JsaW5nQHdkYy5jb20+OyBKYXZpZXIgR29uesOhbGV6DQo+IDxqYXZp
ZXIuZ29uekBzYW1zdW5nLmNvbT47IERhbWllbiBMZSBNb2FsIDxEYW1pZW4uTGVNb2FsQHdkYy5j
b20+Ow0KPiBBZGFtIE1hbnphbmFyZXMgPGEubWFuemFuYXJlc0BzYW1zdW5nLmNvbT47IEtlaXRo
IEJ1c2NoDQo+IDxLZWl0aC5CdXNjaEB3ZGMuY29tPjsgSm9oYW5uZXMgVGh1bXNoaXJuIDxKb2hh
bm5lcy5UaHVtc2hpcm5Ad2RjLmNvbT47DQo+IE5hb2hpcm8gQW90YSA8TmFvaGlyby5Bb3RhQHdk
Yy5jb20+OyBQYW5rYWogUmFnaGF2DQo+IDxwYW5reWRldjhAZ21haWwuY29tPjsgS2FuY2hhbiBK
b3NoaSA8am9zaGkua0BzYW1zdW5nLmNvbT47IE5pdGVzaCBTaGV0dHkNCj4gPG5qLnNoZXR0eUBz
YW1zdW5nLmNvbT4NCj4gU3ViamVjdDogUmU6IFtFWFRdIFtMU0YvTU0vQlBGIEJvRl0gQm9GIGZv
ciBab25lZCBTdG9yYWdlDQo+IA0KPiBDQVVUSU9OOiBFWFRFUk5BTCBFTUFJTC4gRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiByZWNvZ25pemUgdGhl
IHNlbmRlciBhbmQgd2VyZSBleHBlY3RpbmcgdGhpcyBtZXNzYWdlLg0KPiANCj4gDQo+IE9uIDMv
MTUvMjIgMTI6NDcgUE0sIEJlYW4gSHVvIChiZWFuaHVvKSB3cm90ZToNCj4gPiBNaWNyb24gQ29u
ZmlkZW50aWFsDQo+IA0KPiA+DQo+ID4gTWljcm9uIENvbmZpZGVudGlhbA0KPiANCj4gTXVzdCBi
ZSB2ZXJ5IGNvbmZpZGVudGlhbCBpZiBpdCBuZWVkcyB0d28/DQo+IA0KPiBQbGVhc2UgZ2V0IHJp
ZCBvZiB0aGVzZSB1c2VsZXNzIGRpc2NsYWltZXJzIGluIHB1YmxpYyBlbWFpbHMsIHRoZXkgbWFr
ZSBaRVJPIHNlbnNlLg0KPiANCg0KU29ycnkgZm9yIHRoYXQuIFRoZXkgYXJlIGFkZGVkIGJ5IG91
dGxvb2sgYXV0b21hdGljYWxseSwgc2VlbXMgSSBjYW4gdHVybiBpdCBvZmYsIGxldCBtZSBzZWUg
aWYgdGhpcyBlbWFpbCBoYXMgdGhpcyBtZXNzYWdlLg0KDQpLaW5kIHJlZ2FyZHMsDQpCZWFuDQoN
Cj4gLS0NCj4gSmVucyBBeGJvZQ0KDQo=
