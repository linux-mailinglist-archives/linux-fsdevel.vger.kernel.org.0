Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B62472955D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 11:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbjFIJfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 05:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbjFIJfL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:35:11 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9580249F3;
        Fri,  9 Jun 2023 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686303005; x=1717839005;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=MwP52gH9s5nIuzNPSTOh0MQAT4XVP9dWSiZ4RyVd+PI=;
  b=SBlPiN6rgDQij4Gan3Q6YAhs/LxsKRdnRiRKoF9Nx2eYwMiIA4bBV+2M
   x19dFXpBNZLpcxNbyIANul8+OIaySxez7ocwAtHuYmeWxx6LME3gYDIPr
   xH7jwYtcp/k7Laacg/TXN9etrP1BDgtBrGq8ztRUVUd31ZhkuJ+/XnKja
   grq42p6nMSTm3cAQDkhuyfUiPF1OA270NXfmzOEz7cIzfSpPk2x/teiQs
   55pyIyV//C+Ug9Z4vrgs1p+YhDSxL9PWxRTj67nHqTgfVyHIkB2uf3wwn
   Q4tzR8AmStebTrexPmy/fOsPAKGBO44XwYfZNglnpzM82kA7W1gWkScQ0
   w==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681142400"; 
   d="scan'208";a="239096420"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2023 17:29:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYPhkbngXUBPEcpH2F4suwRf6JuaCaFTDIdln0rozPazqJXUz8po4UDdI41LcccIgmjRnAfsp8ki4p9hHVMP7F9CSy8UXTx+/JKVHE6HFA2kIeifGje8/atIXlKnBtPV0OtIo2wn5QKyuu4Hhi02yDndj02AHz9/4i9i7t2JOPLlbObBY9liHMR/PfadkSoWiOt8uFbMc4xFd1YqjRYCGurNEy2jL8l+vPVc/a2eMyFG7+kVIFNtkTcvNOj3Rj9uwcfvD1lvWj6/Bp2Nr8OxK8RQ5V8NQA0+aAWSzekCk7fbII4xDS8RCZGf6pyXt9b48+U5D/xDNnRodk3x5Y1UXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwP52gH9s5nIuzNPSTOh0MQAT4XVP9dWSiZ4RyVd+PI=;
 b=Gc+sM0PHJFhhD05NE37RTOzzMPzPeCqa/SGv3widjKWzrHCe8/nZSC+at8Mbv8PzDYXXdwRTHV9OEmpYJuRlnOShZ+IOl58sXBduVJ5qs8WofMuQ5ABAe++wAHQwJTRMuNSNu+wBR+DVm7cqS9FnuWkEov9szqcWgbNVWlvM7FfIODhihspZ+VKer8RDiHE59nKroZcdzlqVp2JfnN6ceXZiIbCjH1z/EaFFchDg6NQZ7czX4qfcZMyO9lF5j5q/rmMpnmwu8VKWhRL9VdtgWJqvPk2sQxcJpdQam2Fdr0l5jVmMcTPXSoOCq/XS3aVBPWwNn6tIbzkrWE2cl4OMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwP52gH9s5nIuzNPSTOh0MQAT4XVP9dWSiZ4RyVd+PI=;
 b=rvWEvpwUXfV7IW3UxUDzqog7vvYUgBs5D+UqOFrvXsgc4Mj+pRNP9/gYMYKKlT//JsfSu4HFw4TpRxa/DuIQjWFTUHAr1I1Zfw2d3805i849uItxP2XeBALn3+faDzZuDx0uyRmhwiQQBRUKxYUE0nu5iBn4Ms9X362naygPWZM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7487.namprd04.prod.outlook.com (2603:10b6:a03:321::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 09:29:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 09:29:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: [ANNOUNCE] Alpine Linux Persistence and Storage Summit 2023
Thread-Topic: [ANNOUNCE] Alpine Linux Persistence and Storage Summit 2023
Thread-Index: AQHZmrTmYyLaWZV3AUO/yLdrULFZEw==
Date:   Fri, 9 Jun 2023 09:29:33 +0000
Message-ID: <4a6dba36-c03b-96d7-f5e6-205c034cbd52@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7487:EE_
x-ms-office365-filtering-correlation-id: 67497b5b-d033-4029-0d6a-08db68cc08d8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aWDVLiw1erYvfyLvFrmOV2MpjEEOYBCHMLTjtdstiwDUIqqQ3BKtzjWytKAwwBteGWntqgXhxf7kRBUbrckTW9tTIXt5JMG62au/gg36Q1KzJvJuRDT8Gx6WSvuaJ8ojgGWyAu7TvBP/dxg5nDwghx7V8gTo71fTn+EGycfGY8clsZzfzCfUlhocUvulyHlHcC13OmKXS4lvkavfPOhVEAzoZyNo5oLE9R/yyXdKcUU6G7993JlSgf7/i5jl2pvKDcXmp8GTwb6eqMuZHmBVhR2Dy25rm78MeB+JqzmJcc7FgbwAmgxKJQA/oiUsPEWNFRsA58RAD5ymO+7xgw55Aqd+tQwuh2f6iB4jvB5ZjQr5ZqttTTCApDPB9XcsVFccyHZzDz+1BoGQzfJc6Tqj4MqqFuNDfhpHUPbs/Kq6fRFx5QRAk/TqIeUr/rFRaREf5QRRcZfvvqxt5vQ6StVxHejBlGRvbrY0Uyxx2Dj0VgIjYGvPgxo4hXPc+sFCP0zkHgPysJ3DFVFCIYw3fRWPYGXTxs4Wc3qDDnNDRbHNj8RK61UcE1FheZdZf7/V0ZwrFP7aGNnNlYW4uAAYcMwtnOLbnjvJRdDDSSDmE3NNhkPOHOA5xb4DF+RU34rkyg/vimVlzg5sJQROACt0yqBrS2CIWnlD1WmLww0UakByeic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(71200400001)(6486002)(66446008)(64756008)(66556008)(122000001)(66946007)(2906002)(76116006)(66476007)(82960400001)(91956017)(110136005)(38070700005)(38100700002)(8936002)(36756003)(8676002)(5660300002)(86362001)(316002)(31696002)(478600001)(41300700001)(2616005)(966005)(6506007)(6512007)(186003)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek1wQzFSb2Z2TnBObldPQzVLSEdHOStJRzNpYXFZRUo3R2Z2cGpPWUphVVFT?=
 =?utf-8?B?UW9LMyt1RXcrc1lQWkQ0RFZUd09hNDAxenZSY1lSd09NNHB5MDY3Y0VXZnpn?=
 =?utf-8?B?eFZRMG1ZcXFydjM2QXJ4Q0JZV2ZuSS9uR3dGVHAyUmlFczByUUdIcEI3dkFF?=
 =?utf-8?B?d0JqQ1pnRTU3WDh3cEVhTk1HT1BXNDdvVzd5WUNBVmc5NitQUmRmTzJMdkpO?=
 =?utf-8?B?Tkk1cm12dVBobUZJMWluWXBwdjM3ZVFmNGF0SHF4M0swM3Bodm1rL1pQYTR2?=
 =?utf-8?B?a2FOUGE3c3NHU2k1b2poZ1pYQnMyZC95V0ZOUTJpTXJEbVZSbjRVWkVtdlo5?=
 =?utf-8?B?anUrNDNzYnZuZ2JBeHhzUWlaQThGdGVzeGJqYkhURGd1dm96cFpVOTcrdVli?=
 =?utf-8?B?TUI1L3d0NkNxTTJBUzE1clFvQUliUUs3RUFwalkyeDlQNGdrVmhaMjV0dnJk?=
 =?utf-8?B?YUZCbStDa29lRlFtUDBNOXM1Nk4vVWJFS09RRTNSejVWRFFLemZGVkd3eEV1?=
 =?utf-8?B?R1Y0Vzd6ZjlSemdDdU82R0ExeE5vdzZ3bXVCWURLam9vK25wSlAwa1FIRTY5?=
 =?utf-8?B?bEQ3aDZrL1E0QVV1WmpCTHprMnJsemtGWmFSVmxMSHNwS2MxNE5sRmcrSHRu?=
 =?utf-8?B?c1hkS0lhY3F0WTVVd25PYUpKWVpmSW9yQ21TRldyLy8ya1NsNlR5RFBrT2Zm?=
 =?utf-8?B?dXJuR094OEdFTGliSmNCb0NwVTl5QkFjRk9ad3oyZGZ3V1JiYlpPemJidlUy?=
 =?utf-8?B?Sy9RTTZ1aXZ1VUtBbjMxL0FiQVRLQllhbWVOS2lEcGhDZUVOWXYrNFRZd0xl?=
 =?utf-8?B?K1pHT1lyOEw4MjIyQUZPK2YvQUF5RVN5MkNXSkNiUWZQcEwwS3d6SFhwSlZ1?=
 =?utf-8?B?c3VncVlVblErKzFtUGV3b0pRRXJGZUVlUFRNTlVoRlpCbE1qL0lsTzJ4MjZ3?=
 =?utf-8?B?Ly9NaDZFUHJaZ3F4NFFpMHY5UDhLdzhxRHNpQ1BJaUhON0M1eXJUdG1DTW1p?=
 =?utf-8?B?SEFFaFg2WHVkeWQ5SUFmclA0bVNra0Z5WUpvaElFbmw5ZHNMdFozbnBkTzFG?=
 =?utf-8?B?V09iUGdpb1M1VFV0NlVWRFY1NTl4TEx5NENOUzVaRVErRm9jOE00ZWlnYVZn?=
 =?utf-8?B?OUJZRWlpb1V5UXk3ck5wcTNTUVcrbGNDVUMyS3ZxRmg4RVNYSlVDNXVVY1pE?=
 =?utf-8?B?STR6OFJxN2Jwb1FieE5wOW1ZempGNmhNS00rMi9SZG9SSkdCL2drSFhrNUxm?=
 =?utf-8?B?bjdPa0lVSFVPMUJoUzdmeW5NRE9oVDNTLzl1b3ZJRUpxZzhlV1hnaDgzQS9H?=
 =?utf-8?B?TmE1NzBKTnpxODNVZDhRYTl5cU5HVi9kWXAxRmprWFl4MGxUa0dkOFpTamY3?=
 =?utf-8?B?U0dlWFp2c2k5aEJwUWVtRE1qVDhHcXdDZHhpbHM1eDZrU0Z0dThUdUlYdHM1?=
 =?utf-8?B?UFpMMGo4a1lDRmZGTkhmaytZM1pnTjNvZ3NvMDY1UkVBNS9ycnAwK3VtczFw?=
 =?utf-8?B?SThjWVl4TUw3Rjh4dXNKd1FaSE50SERCUUp3Y3dZOWtZdkN5bWJOd2lLUmFB?=
 =?utf-8?B?QStEQllOMnJaRjluVEhBaXUzZVAyTkJWVXBOcTZ6cERCMitpNGw4NHdEMi8y?=
 =?utf-8?B?UFZoOWJFZldVQ2hSY29FMm5RaWFBdDFVWXk2V0hXVjl2Zkw2ZmwzeCt3cHRj?=
 =?utf-8?B?Rk9YRnBRWm94bVJydVhocUVobUZiQ05HbXdFbm5UL294WnhwMWRRMkUzOGFv?=
 =?utf-8?B?V3FkalcxNXVHYlEwZ0VlTXZwbU1Tem1CSlNZaFVCcFFoeWxIdVFhdWhRNFlX?=
 =?utf-8?B?eTg2bXpqZkhDN2FISWg1YXBKb3N4SVF6MU81VENwaXBPSmZ3Y3ZnOTc1VVMr?=
 =?utf-8?B?Q1FIclVVVWI4UWdaWlVaUVRWOFBFQktOVlZzY0RaTVJzZlEwM05zQnpoS2Zr?=
 =?utf-8?B?SkpYZUlhd3Z4UXMrZDJTMUw1MW9yYkdycHI3aWNnTzBHc04wS0NCczN1UFJx?=
 =?utf-8?B?Z1lYYkN1dDMvVURjbEZkaWRlNER4TTJDZGtOcFpIMnlzeVY0VTZWR0hPWWhK?=
 =?utf-8?B?Q1pqU2FrUytEQVlDbTNuSUE0bnRKaEtCeW0xY3lUbU9YT29WUVU0bjdpVUJn?=
 =?utf-8?B?K3NCT3V1MVhra1RmdUFlRHhKa0NBekRIR3ZqS1dCNkg5c3o0eGVSeDM4ZnNJ?=
 =?utf-8?B?RjNRa0hudys0ODlXNmphRkVpTGxCYlNnQ1BKSWI4akhTeWF4cmNsdU5aTlMx?=
 =?utf-8?B?ZzcyanBlVm1kdVMzL3QrSkt5SEF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <831A33F961616F43AC62FA6E7D47013C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1FfLBdH4y+Dc+tYmDj0+ucQJg4gBoUpbqdkSnHhwDl2NuhXtbSyGxaMGi6Pe8mOk2duyIR4U4LNn1RPH0vPqIbx9LOtlhUGLy8C6E9n49ybI31jesJS2Z3um8As+UPH7xmyJzCtjLs0IiNmENrxbAAFbI87Nt0TW+JdoklqTN/0OQmvXxZ2PApf1GvqKV5H3oU7nbfQf/M7SduGUojLeWcryRx1WLQJ4SGRCjGe1iJNvZCe60sUaQ6Om7HQadKSH2FkYp18QKbvbrSGttJRSqPjdOxv6Y8lU4Ciq66GoGNtJVgilFXUtPXESmCSwKJ4m5EpPxIgOL0U94IWYm+sBTlh9ErTwXrOW/gdKyXOEZ27vO3C+GIXC1K3XH+Xgi3gYqmicpakZykqS3Y4VCwyBHjlAvbaHO3o0mhxt8hSYSe18nma5U9AZ1sp9HqsPuk/HJT+w4Vh1+h+5InZwl3TRfizAI50+LGNaZRAMPSa5SUR83CgrFlx2xjyZ5JgnwLAinSO6GJWNJYqvL4+bBexwSB8gchgZi5DaFFq3yXbJgfa4C4kgI74FWTwDUL1Sj//3nvpgv3pGK91Q2DqtG5hseIJ6TVY6qbDL73Th/eJlFCCzM2NQ7UU46F7bzjpBly2OTf5y1Z8hD/bU0Evzxs8dzrZ1PIZvwgvSMK5378DJTyh3reJoRQOcCIXB0NybeEh4yeGbtxQ0szOP3FikNXQThf/atfNymy0SAUyhR0IV5WgJ223SBaulM6KoVfOuT2gFIP296BKsP86OcGorL308Ix/SSpbCTqXWnhf1zsOBU1OTT5ggsuQScuWGrRVjQ5NHhX/m4BGAxcuHTtNc+8Ucrw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67497b5b-d033-4029-0d6a-08db68cc08d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 09:29:33.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knH0zvkuHj2ykas/XKaYAhrwwG9DYPNMq59lU0hxbsZX7dMwY1f4Zqt4BfBVEG94DsyXUh5bLIrEVnhxbd1qOjA003LvywQKFzd1+xD54+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7487
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

V2UgcHJvdWRseSBhbm5vdW5jZSB0aGUgNnRoIEFscGluZSBMaW51eCBQZXJzaXN0ZW5jZSBhbmQg
U3RvcmFnZSBTdW1taXQNCihBTFBTUyksIHdoaWNoIHdpbGwgYmUgaGVsZCBTZXB0ZW1iZXIgMjZ0
aCB0byAyOXRoIGF0IHRoZSBMaXp1bWVyaHVldHRlIFsxXQ0KWzJdIGluIEF1c3RyaWEuDQoNClRo
ZSBnb2FsIG9mIHRoaXMgY29uZmVyZW5jZSBpcyB0byBkaXNjdXNzIHRoZSBob3QgdG9waWNzIGlu
IExpbnV4IHN0b3JhZ2UNCmFuZCBmaWxlIHN5c3RlbXMsIHN1Y2ggYXMgcGVyc2lzdGVudCBtZW1v
cnksIE5WTWUsIHpvbmVkIHN0b3JhZ2UsIGFuZCBJL08NCnNjaGVkdWxpbmcgaW4gYSBjb29sIGFu
ZCByZWxheGVkIHNldHRpbmcgd2l0aCBzcGVjdGFjdWxhciB2aWV3cyBpbiB0aGUNCkF1c3RyaWFu
IGFscHMuDQoNCldlIHBsYW4gdG8gaGF2ZSBhIHNtYWxsIHNlbGVjdGlvbiBvZiBzaG9ydCBhbmQg
dG8gdGhlIHBvaW50IHRhbGtzIHdpdGgNCmxvdHMgb2Ygcm9vbSBmb3IgZGlzY3Vzc2lvbiBpbiBz
bWFsbCBncm91cHMsIGFzIHdlbGwgYXMgYW1wbGUgZG93bnRpbWUNCnRvIGVuam95IHRoZSBzdXJy
b3VuZGluZy4NCg0KQXR0ZW5kYW5jZSBpcyBmcmVlIGV4Y2VwdCBmb3IgdGhlIGFjY29tbW9kYXRp
b24gYW5kIGZvb2QgYXQgdGhlIGxvZGdlIFszXSwNCmJ1dCB0aGUgbnVtYmVyIG9mIHNlYXRzIGlz
IHN0cmljdGx5IGxpbWl0ZWQuICBJZiB5b3UgYXJlIGludGVyZXN0ZWQgaW4NCmF0dGVuZGluZyBw
bGVhc2UgcmVzZXJ2ZSBhIHNlYXQgYnkgbWFpbGluZyB5b3VyIGZhdm9yaXRlIHRvcGljKHMpIHRv
Og0KDQoJYWxwc3MtcGNAcGVuZ3VpbmdhbmcuYXQNCg0KSWYgeW91IGFyZSBpbnRlcmVzdGVkIGlu
IGdpdmluZyBhIHNob3J0IGFuZCBjcmlzcCB0YWxrIHBsZWFzZSBhbHNvIHNlbmQNCmFuIGFic3Ry
YWN0IHRvIHRoZSBzYW1lIGFkZHJlc3MuDQoNClRoZSBMaXp1bWVyaHVldHRlIGlzIGFuIEFscGlu
ZSBTb2NpZXR5IGxvZGdlIGluIGEgaGlnaCBhbHBpbmUgZW52aXJvbm1lbnQuDQpBIGhpa2Ugb2Yg
YXBwcm94aW1hdGVseSAyIGhvdXJzIGlzIHJlcXVpcmVkIHRvIHRoZSBsb2RnZSwgYW5kIG5vIG90
aGVyDQphY2NvbW1vZGF0aW9ucyBhcmUgYXZhaWxhYmxlIHdpdGhpbiB3YWxraW5nIGRpc3RhbmNl
Lg0KDQpUaGFuayB5b3Ugb24gYmVoYWxmIG9mIHRoZSBwcm9ncmFtIGNvbW1pdHRlZToNCg0KICAg
IENocmlzdG9waCBIZWxsd2lnDQogICAgSm9oYW5uZXMgVGh1bXNoaXJuDQogICAgUmljaGFyZCBX
ZWluYmVyZ2VyDQoNClsxXSBodHRwOi8vd3d3LnR5cm9sLmNvbS90aGluZ3MtdG8tZG8vc3BvcnRz
L2hpa2luZy9yZWZ1Z2UtaHV0cy9hLWxpenVtZXItaHV0DQpbMl0gaHR0cHM6Ly93d3cuZ2x1bmdl
emVyLmF0L2wtaS16LXUtbS1lLXItaC0lQzMlQkMtdC10LWUvDQpbM10gYXBwcm94LiBFVVIgNTAt
NzAgcGVyIHBlcnNvbiBhbmQgbmlnaHQsIGRlcGVuZGluZyBvbiB0aGUgcm9vbQ0KICAgIGNhdGVn
b3J5DQoNCg==
