Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F524CBAAA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 10:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiCCJt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 04:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiCCJtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:49:55 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCE7151C63;
        Thu,  3 Mar 2022 01:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646300948; x=1677836948;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z/QK7ba546peGsvWZ025YZ/ldAxIOYcBHhzN2gS3e2Q=;
  b=aw9cukKrk7p9dTVpyTUTv6izrSDF6oYOwpezZyae2Fx9wj1FEkUD35/O
   j24Wm1K+hw/GFhAZ+VLn9U6T8pn73AGxCrBcugwVaN5TMHIGObd2+mPbH
   iu35iKGTgtm4ZXS49df8zJqG34N044NxTFRpml1gr7kjCTV7pKo5542LH
   gUA20/zmkNf3XIndUxLFMt2uZt0rUMeHgoNbWay8o4a6VJsQ2/La7AuHH
   su7dZl64qGhab+7mupUSJDoSxoFD8dv9VnYe8TENRFx1BO18BNlm38XKZ
   walgBu3mQgEGg8EHEbGJPkXvvlK+Rb3S0oqSHEo1NDHFD7g59Na5A9EwD
   g==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="194374434"
Received: from mail-bn1nam07lp2045.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.45])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2022 17:49:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTt/6eseSErlR+7CNzOCGSavcvdKd+GAeqGCR6znVItIKt/Cdr1nHyaYysT5fagnz+mvVlMg+OAYew5SOSwd/gq/8PgLoZElDvk7q3Mo2sFMmvm2GFle3L7EtL80zpD3wvIpRVY/6RXJjmH7Lzj+/5VBSKXKfZLGTnnai78jjI0ZkTOjHgIuJuTuCF64Jg294ngu0HuC+h7q9lv4oHEXY7+pEXEEfvuibKbBGneOh6aWmbHVzJBsEbBjpIoBH8e3jHxMAp1ChtrWFQeeVzXD7b+Z44dUd9lZnmIHAGzh3JHsKeUsvtgOr9Gb0PuQDQQytph0oOKiLPjhH+aRP5CNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/QK7ba546peGsvWZ025YZ/ldAxIOYcBHhzN2gS3e2Q=;
 b=YiFZAa/Flq/mf/EJ5WRmIqAuCYsDkwHm0IG7ZkeemU3IpxJBxs2Sqi9PqjCw4Atn9hHRYaeMrqxGWk3m9ChSFaoblAzM7JQ+SMg5plSgX/GOvvvsXoxQ0qOnfeKMl5jwavQMlAsoODrNZzZlhsmHXcCb0yHxRWjiMMlbEEscQYHA86I3K5DxFATwluSQVFVfDIv3x3bQHwEeselukds4gzFiKS/eF5w+0s3G2F6Ad6eRYVAz72GPQMTOAB2jxfpvawub8Mw0sWHRJ/i5fZKRdn1db2nU946rMAWEyBSKNVIKhnrZpup20S0Qs0IjDlglAzkueJBmzJYAm4xaKIrQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/QK7ba546peGsvWZ025YZ/ldAxIOYcBHhzN2gS3e2Q=;
 b=Zz+/gQGo92pXn+xx/tXUDwQG9uK0e883fC9QHe8tWWOBbE3KxJ7mXQhgRJNrgIszMDUJ29539a5xgV6BdNx49/lVQWimmD/DNjuNO8ljO3hKdy5hsU//s+qD+3iXOoc4r9iyL6bY1LXcyUjKgW8GHll6JVB4lSd5wmmNe4FU7NQ=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by BN6PR04MB0948.namprd04.prod.outlook.com (2603:10b6:405:43::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 09:49:06 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::c8f4:8499:a5fc:1835]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::c8f4:8499:a5fc:1835%3]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 09:49:06 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmd1Ny4qtE3bUeyZ6TIm7TKKqytIu+AgAAQCQCAADergA==
Date:   Thu, 3 Mar 2022 09:49:06 +0000
Message-ID: <8386a6b9-3f06-0963-a132-5562b9c93283@wdc.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
 <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
In-Reply-To: <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b71d2ec6-acb6-414b-6739-08d9fcfb0ef7
x-ms-traffictypediagnostic: BN6PR04MB0948:EE_
x-microsoft-antispam-prvs: <BN6PR04MB094847802E7A9ACACFD16970E7049@BN6PR04MB0948.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XiLnjVJ3FsQeEYqSqg5itgwR0wEl69B701TTzncrzVgJKqx+AIhI6/Fm/8k+Lq8ojs7NLXivNBLrD5LHlbxUZhePOEIPhwlnEIH7Z9ojIAL+Qzo1lSsozmysd4Qcdr8U2Ly5Y9xG+cpYxDcc3E8tOMOr1jsuzvxQWJoLsMBFTMUjEeiSAnZcbSkHEHax8p+lVYJjiM4t6lxqIPoRvPCSbGYuTk7F6TvxHTP5ianxJBBfMHblrEMsaLb/Fh5hPUbNHx2mY2UK8I/2GYWndeuqVBYLk5VGxiVHKtclPUoLyHYiNLsIg2EAcobybNVik2KqPeCFI5ntjYfdmN47C9T3PmzvWH7Po7n1UtWw59Z3vDccmDP3fDC9Y8j5Dg1KozV16dChDTyvVK7Mj3D7TW8qv0eYz6ICq8RLybd+UrHSxSbXg/sBMAuGNYKLpf5IPzkF8Hx0k3VM+ZknbE7w9IO+P+dNcKgSzCjgN6fnwYSNX0rd4BJ6ai4shSRI8UwrPU0DsjusxqsFHqP1W7DgrzZqn9V52vNw0f1/iKPmszUNbYlCCKZhYe55tW+4yGZPcmHkJZhDD26pOGmRDS06YeV+0zQsNdAXA06fzNCaie8mf/0i2CLyZuqnuE270uPROx2oDj3K4oASuTjPTBAnZtGmpS7F8C6B24gib+p4CdzeEGfFzsgvoq7yXbzvhTx6G3xshC+2/Txj7zJnWFLgimBgL3GATxk1YxS+drAWHrwCE65Dp02ccyxYtgB7nEzBdzgWpjxCMFopsOFt7sRbI2qOVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(38070700005)(2616005)(36756003)(8936002)(6512007)(316002)(186003)(26005)(76116006)(8676002)(6506007)(122000001)(66946007)(91956017)(7416002)(2906002)(5660300002)(66556008)(66476007)(66446008)(82960400001)(64756008)(66574015)(4326008)(53546011)(54906003)(71200400001)(86362001)(508600001)(31696002)(83380400001)(110136005)(6486002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDh0elhzUmxqZThEUnQwUE9CclJHK1l1YTJKTEFmUk5iQ3N6b0pqWDMzeEQz?=
 =?utf-8?B?S2tPUWhucFFiUDdrN2syeWhwQ3BvTkFDOWQ4RnZvOVluR25TbkxmT1MrZ2pM?=
 =?utf-8?B?TWZkbFFxbzVWWVdXWHI0YVJrU1RXTlVKVFRKdVl4Qk1OZjA1SHdJL0hJWWp5?=
 =?utf-8?B?K2ZPVURaTGpKelk4WElSVWc3U08wdkZrUUZHVWNmY2NTb2NZZkpIenBCaHE3?=
 =?utf-8?B?LzdrRUp3VTk0ZUFXenZIekZTOUh3akRNWDhDUzRMcXVrcnBQQyszYzNtd01j?=
 =?utf-8?B?anFuTkZqM2hjcDhVTEhGQ0lJZHB5K2VRUVBxelJyc1p5NTlNSXVQNmltNFdz?=
 =?utf-8?B?ZFI5U2RhTHhRVTlmZUY0K2V1ZkEvazJkb2xrWnFPTHJCR0d6YWQyaDlBa2Nj?=
 =?utf-8?B?bDRmY1VqdnFQTFFXSjBDWFdrd0N5OVBDaXZmaWJCVGNSY2tqTEdUL3p0Sklp?=
 =?utf-8?B?RXhyZzJzeERVcDQ0VVdLb0RSeEo5NUZER2xMaHVPa3dGUWpUeGozOWRUc1ZV?=
 =?utf-8?B?QWpZRmRyenZuaTRJVHdpekhHR1RCbzBUYjc1anQvZ0M3Y2d4MkF3LzErckFN?=
 =?utf-8?B?VVprdklyQkFrUmlGcm5MQVN2U0d1OGpkQ2NKeEFPczhLZmIyd3FaMVRXU0VC?=
 =?utf-8?B?ZVVvYVRFUm55SzR0Y3Y0cXA5T25sRXB1Qk5EVmlWaWVsZFJPaVBaa09xSnhS?=
 =?utf-8?B?ZVhsbVRMTW52VDBHSUF1ZXNlSzVDWWREN1B5ditHd0tMQzZ3dnhZVEJoZkE2?=
 =?utf-8?B?bE0wbUlWV25kQW05S0lWamwwVVVIc3JrS1pYc3NxVWEraHNKdTlRcDZOdmdN?=
 =?utf-8?B?TktOOTVhZElVeklmY2xEelBaakNrYXZwaFdVWUdQVktBeVY3Zm84MktkVDFt?=
 =?utf-8?B?QjVjNWJtbTNackJJdlU4YnN5VThrWEVVOTNwamdnalhtT0VneTFTais3akEw?=
 =?utf-8?B?QVdQY1JRSHcvT09vbnZoeTZ2cWNFTS9QRktyZEtwZ2ZKMVRxaWI2YWdoSEp5?=
 =?utf-8?B?NUVqREo5UW11RUFzZXdFMlljTXZNOE9WblJxN1FDVWcxbSsxMXZ0dXlOUGQ2?=
 =?utf-8?B?TjdiMjlPd0dRNHNydU8wdFc1VzJiN2JMN3BJcE14NXo3N1UxYlhza0RqMnNF?=
 =?utf-8?B?bkxqWWtVU2VXQWhJZFgxU1NBUDQxK2NMbCs2Z1A4eThRNkpWQjZPM0xpYUhW?=
 =?utf-8?B?aUhYMW1oVVVZSzQ0akFIRmNlSFdObW9BK2djQ3ZUVmdTekxPd0ltTXByRFZP?=
 =?utf-8?B?VHRPdStwVUgxQnRmVzMyRHVCa05WU2dkdWtuc1hVck9PdVk0enYxMzVnS1pJ?=
 =?utf-8?B?dmY3dmJqN0VMVEhLWitndldWWmExbVVpMnhGVzlkNGU4VVZsVlBvTEpkWS91?=
 =?utf-8?B?UkNDdXBUdFhxbC9pempiRG9ZSzVzNUp3QWNSQVh5UmwrcG10bUFONWNCbHRk?=
 =?utf-8?B?OGNjSFozV2JLTE11RmVNM09aTEdoQVRCN2hYNUtHN0lCRUZkYzFjU0FOeS9r?=
 =?utf-8?B?aFFxOTY3YU1OcUNtMGh3TDhBcWc0S2ZKTitKT09HSmMzcDNPL1dwS09mQnds?=
 =?utf-8?B?eXZiZmNEc09XUUQ5WjdDMHN6ME5NZUQvUitMWHpIdXZZajRvWG1md24yOThX?=
 =?utf-8?B?ZzNCNW96Vnp1UGllRWJxS3YrZHFqcUc1dWlyRmpHODkxTllUbW8vRWd5L1lR?=
 =?utf-8?B?d3ptUmFock15WkJ2dmtvV1d6U2R6RmZpMFozK3I5eGlHSStrYUl5RE02SEJr?=
 =?utf-8?B?eUQyN0RmZFY4MG1JQmc5czI3b3NTZ1ZyNFJNcytvVVVEYnZ4UjFKNTBaWXZ4?=
 =?utf-8?B?RFdDYlErbWhVcUZ4Z1h6eFRMcGJ5aW1Ra0lLeHZyMHlEM1ZMMXlrUHZNeTZP?=
 =?utf-8?B?enhiVEoycWd0K0hJc05TUEd4R0l4QSs0RnJzS05OQm9ZdURobzhaZkJqVmlK?=
 =?utf-8?B?Q2RLSVZHMTh3ZklhVStnOWI3RkRXYkNIZC9yRjN4NFB5ekhvYnFFTUJkU1lr?=
 =?utf-8?B?SHVaWmp0SG9aR3MwcjBicGpLSzZPdUVBRldZVVE0QmxPRVQ1UlcrRnh4N0lC?=
 =?utf-8?B?T1EzVzhEQkhTV052R0ZZT3B3b21VSDNXcFByamNaNG9heVFHV05mMVBZdXI1?=
 =?utf-8?B?NVZqWGZnRzF0RUdGRTRMMzVGK1NwazJ1Vm9KOUxIQVdId25WYlU0UUlpdXhs?=
 =?utf-8?Q?2vaOE98qznL8oZoI5Ycza22QtLft8qy0RGIO752o3jxx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CC174F2DC46DB429D6BA74C4EA74835@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71d2ec6-acb6-414b-6739-08d9fcfb0ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 09:49:06.5847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBtoeJ/WhlPr3ih+IDze08nd6/NJdLBTVxfMvazSYr0Ne8bzwJiZULRSF1hbGceQzXu3CDYAMhaFdgwJQCipWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0948
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjAyMi8wMy8wMyA4OjI5LCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOg0KPiBPbiAwMy4wMy4y
MDIyIDA2OjMyLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOg0KPj4NCj4+PiBPbiAzIE1hciAyMDIy
LCBhdCAwNC4yNCwgTHVpcyBDaGFtYmVybGFpbiA8bWNncm9mQGtlcm5lbC5vcmc+IHdyb3RlOg0K
Pj4+DQo+Pj4g77u/VGhpbmtpbmcgcHJvYWN0aXZlbHkgYWJvdXQgTFNGTU0sIHJlZ2FyZGluZyBq
dXN0IFpvbmUgc3RvcmFnZS4uDQo+Pj4NCj4+PiBJJ2QgbGlrZSB0byBwcm9wb3NlIGEgQm9GIGZv
ciBab25lZCBTdG9yYWdlLiBUaGUgcG9pbnQgb2YgaXQgaXMNCj4+PiB0byBhZGRyZXNzIHRoZSBl
eGlzdGluZyBwb2ludCBwb2ludHMgd2UgaGF2ZSBhbmQgdGFrZSBhZHZhbnRhZ2Ugb2YNCj4+PiBo
YXZpbmcgZm9sa3MgaW4gdGhlIHJvb20gd2UgY2FuIGxpa2VseSBzZXR0bGUgb24gdGhpbmdzIGZh
c3RlciB3aGljaA0KPj4+IG90aGVyd2lzZSB3b3VsZCB0YWtlIHllYXJzLg0KPj4+DQo+Pj4gSSds
bCB0aHJvdyBhdCBsZWFzdCBvbmUgdG9waWMgb3V0Og0KPj4+DQo+Pj4gICogUmF3IGFjY2VzcyBm
b3Igem9uZSBhcHBlbmQgZm9yIG1pY3JvYmVuY2htYXJrczoNCj4+PiAgICAgIC0gYXJlIHdlIHJl
YWxseSBoYXBweSB3aXRoIHRoZSBzdGF0dXMgcXVvPw0KPj4+ICAgIC0gaWYgbm90IHdoYXQgb3V0
bGV0cyBkbyB3ZSBoYXZlPw0KPj4+DQo+Pj4gSSB0aGluayB0aGUgbnZtZSBwYXNzdGhyb2doIHN0
dWZmIGRlc2VydmVzIGl0J3Mgb3duIHNoYXJlZA0KPj4+IGRpc2N1c3Npb24gdGhvdWdoIGFuZCBz
aG91bGQgbm90IG1ha2UgaXQgcGFydCBvZiB0aGUgQm9GLg0KPj4+DQo+Pj4gIEx1aXMNCj4+DQo+
PiBUaGFua3MgZm9yIHByb3Bvc2luZyB0aGlzLCBMdWlzLg0KPj4NCj4+IEnigJlkIGxpa2UgdG8g
am9pbiB0aGlzIGRpc2N1c3Npb24gdG9vLg0KPj4NCj4+IFRoYW5rcywNCj4+IEphdmllcg0KPiAN
Cj4gTGV0IG1lIGV4cGFuZCBhIGJpdCBvbiB0aGlzLiBUaGVyZSBpcyBvbmUgdG9waWMgdGhhdCBJ
IHdvdWxkIGxpa2UgdG8NCj4gY292ZXIgaW4gdGhpcyBzZXNzaW9uOg0KPiANCj4gICAgLSBQTzIg
em9uZSBzaXplcw0KPiAgICAgICAgSW4gdGhlIHBhc3Qgd2Vla3Mgd2UgaGF2ZSBiZWVuIHRhbGtp
bmcgdG8gRGFtaWVuIGFuZCBNYXRpYXMgYXJvdW5kDQo+ICAgICAgICB0aGUgY29uc3RyYWludCB0
aGF0IHdlIGN1cnJlbnRseSBoYXZlIGZvciBQTzIgem9uZSBzaXplcy4gV2hpbGUNCj4gICAgICAg
IHRoaXMgaGFzIG5vdCBiZWVuIGFuIGlzc3VlIGZvciBTTVIgSEREcywgdGhlIGdhcCB0aGF0IFpO
Uw0KPiAgICAgICAgaW50cm9kdWNlcyBiZXR3ZWVuIHpvbmUgY2FwYWNpdHkgYW5kIHpvbmUgc2l6
ZSBjYXVzZXMgaG9sZXMgaW4gdGhlDQo+ICAgICAgICBhZGRyZXNzIHNwYWNlLiBUaGlzIHVubWFw
cGVkIExCQSBzcGFjZSBoYXMgYmVlbiB0aGUgdG9waWMgb2YNCj4gICAgICAgIGRpc2N1c3Npb24g
d2l0aCBzZXZlcmFsIFpOUyBhZG9wdGVycy4NCj4gDQo+ICAgICAgICBPbmUgb2YgdGhlIHRoaW5n
cyB0byBub3RlIGhlcmUgaXMgdGhhdCBldmVuIGlmIHRoZSB6b25lIHNpemUgaXMgYQ0KPiAgICAg
ICAgUE8yLCB0aGUgem9uZSBjYXBhY2l0eSBpcyB0eXBpY2FsbHkgbm90LiBUaGlzIG1lYW5zIHRo
YXQgZXZlbiB3aGVuDQo+ICAgICAgICB3ZSBjYW4gdXNlIHNoaWZ0cyB0byBtb3ZlIGFyb3VuZCB6
b25lcywgdGhlIGFjdHVhbCBkYXRhIHBsYWNlbWVudA0KPiAgICAgICAgYWxnb3JpdGhtcyBuZWVk
IHRvIGRlYWwgd2l0aCBhcmJpdHJhcnkgc2l6ZXMuIFNvIGF0IHRoZSBlbmQgb2YgdGhlDQo+ICAg
ICAgICBkYXkgYXBwbGljYXRpb25zIHRoYXQgdXNlIGEgY29udGlndW91cyBhZGRyZXNzIHNwYWNl
IC0gbGlrZSBpbiBhDQo+ICAgICAgICBjb252ZW50aW9uYWwgYmxvY2sgZGV2aWNlIC0sIHdpbGwg
aGF2ZSB0byBkZWFsIHdpdGggdGhpcy4NCg0KInRoZSBhY3R1YWwgZGF0YSBwbGFjZW1lbnQgYWxn
b3JpdGhtcyBuZWVkIHRvIGRlYWwgd2l0aCBhcmJpdHJhcnkgc2l6ZXMiDQoNCj8/Pw0KDQpObyBp
dCBkb2VzIG5vdC4gV2l0aCB6b25lIGNhcCA8IHpvbmUgc2l6ZSwgdGhlIGFtb3VudCBvZiBzZWN0
b3JzIHRoYXQgY2FuIGJlDQp1c2VkIHdpdGhpbiBhIHpvbmUgbWF5IGJlIHNtYWxsZXIgdGhhbiB0
aGUgem9uZSBzaXplLCBidXQ6DQoxKSBXcml0ZXMgc3RpbGwgbXVzdCBiZSBpc3N1ZWQgYXQgdGhl
IFdQIGxvY2F0aW9uIHNvIGNob29zaW5nIGEgem9uZSBmb3Igd3JpdGluZw0KZGF0YSBoYXMgdGhl
IHNhbWUgY29uc3RyYWludCByZWdhcmRsZXNzIG9mIHRoZSB6b25lIGNhcGFjaXR5OiBEbyBJIGhh
dmUgZW5vdWdoDQp1c2FibGUgc2VjdG9ycyBsZWZ0IGluIHRoZSB6b25lID8NCjIpIFJlYWRpbmcg
YWZ0ZXIgdGhlIFdQIGlzIG5vdCB1c2VmdWwgKGlmIG5vdCBvdXRyaWdodCBzdHVwaWQpLCByZWdh
cmRsZXNzIG9mDQp3aGVyZSB0aGUgbGFzdCB1c2FibGUgc2VjdG9yIGluIHRoZSB6b25lIGlzIChh
dCB6b25lIHN0YXJ0ICsgem9uZSBzaXplIG9yIGF0DQp6b25lIHN0YXJ0ICsgem9uZSBjYXApLg0K
DQpBbmQgdGFsa2luZyBhYm91dCAidXNlIGEgY29udGlndW91cyBhZGRyZXNzIHNwYWNlIiBpcyBp
biBteSBvcGluaW9uIG5vbnNlbnNlIGluDQp0aGUgY29udGV4dCBvZiB6b25lZCBzdG9yYWdlIHNp
bmNlIGJ5IGRlZmluaXRpb24sIGV2ZXJ5dGhpbmcgaGFzIHRvIGJlIG1hbmFnZWQNCnVzaW5nIHpv
bmVzIGFzIHVuaXRzLiBUaGUgb25seSBzZW5zaWJsZSByYW5nZSBmb3IgYSAiY29udGlndW91cyBh
ZGRyZXNzIHNwYWNlIg0KaXMgInpvbmUgc3RhcnQgKyBtaW4oem9uZSBjYXAsIHpvbmUgc2l6ZSki
Lg0KDQo+ICAgICAgICBTaW5jZSBjaHVua19zZWN0b3JzIGlzIG5vIGxvbmdlciByZXF1aXJlZCB0
byBiZSBhIFBPMiwgd2UgaGF2ZQ0KPiAgICAgICAgc3RhcnRlZCB0aGUgd29yayBpbiByZW1vdmlu
ZyB0aGlzIGNvbnN0cmFpbnQuIFdlIGFyZSB3b3JraW5nIGluIDINCj4gICAgICAgIHBoYXNlczoN
Cj4gDQo+ICAgICAgICAgIDEuIEFkZCBhbiBlbXVsYXRpb24gbGF5ZXIgaW4gTlZNZSBkcml2ZXIg
dG8gc2ltdWxhdGUgUE8yIGRldmljZXMNCj4gCXdoZW4gdGhlIEhXIHByZXNlbnRzIGEgem9uZV9j
YXBhY2l0eSA9IHpvbmVfc2l6ZS4gVGhpcyBpcyBhDQo+IAlwcm9kdWN0IG9mIG9uZSBvZiBEYW1p
ZW4ncyBlYXJseSBjb25jZXJucyBhYm91dCBzdXBwb3J0aW5nDQo+IAlleGlzdGluZyBhcHBsaWNh
dGlvbnMgYW5kIEZTcyB0aGF0IHdvcmsgdW5kZXIgdGhlIFBPMg0KPiAJYXNzdW1wdGlvbi4gV2Ug
d2lsbCBwb3N0IHRoZXNlIHBhdGNoZXMgaW4gdGhlIG5leHQgZmV3IGRheXMuDQo+IA0KPiAgICAg
ICAgICAyLiBSZW1vdmUgdGhlIFBPMiBjb25zdHJhaW50IGZyb20gdGhlIGJsb2NrIGxheWVyIGFu
ZCBhZGQNCj4gCXN1cHBvcnQgZm9yIGFyYml0cmFyeSB6b25lIHN1cHBvcnQgaW4gYnRyZnMuIFRo
aXMgd2lsbCBhbGxvdyB0aGUNCj4gCXJhdyBibG9jayBkZXZpY2UgdG8gYmUgcHJlc2VudCBmb3Ig
YXJiaXRyYXJ5IHpvbmUgc2l6ZXMgKGFuZA0KPiAJY2FwYWNpdGllcykgYW5kIGJ0cmZzIHdpbGwg
YmUgYWJsZSB0byB1c2UgaXQgbmF0aXZlbHkuDQoNClpvbmUgc2l6ZXMgY2Fubm90IGJlIGFyYml0
cmFyeSBpbiBidHJmcyBzaW5jZSBibG9jayBncm91cHMgbXVzdCBiZSBhIG11bHRpcGxlIG9mDQo2
NEsuIFNvIGNvbnN0cmFpbnRzIHJlbWFpbiBhbmQgc2hvdWxkIGJlIGVuZm9yY2VkLCBhdCBsZWFz
dCBieSBidHJmcy4NCg0KPiANCj4gCUZvciBjb21wbGV0ZW5lc3MsIEYyRlMgd29ya3MgbmF0aXZl
bHkgaW4gUE8yIHpvbmUgc2l6ZXMsIHNvIHdlDQo+IAl3aWxsIG5vdCBkbyB3b3JrIGhlcmUgZm9y
IG5vdywgYXMgdGhlIGNoYW5nZXMgd2lsbCBub3QgYnJpbmcgYW55DQo+IAliZW5lZml0LiBGb3Ig
RjJGUywgdGhlIGVtdWxhdGlvbiBsYXllciB3aWxsIGhlbHAgdXNlIGRldmljZXMNCj4gCXRoYXQg
ZG8gbm90IGhhdmUgUE8yIHpvbmUgc2l6ZXMuDQo+IA0KPiAgICAgICBXZSBhcmUgd29ya2luZyB0
b3dhcmRzIGhhdmluZyBhdCBsZWFzdCBhIFJGQyBvZiAoMikgYmVmb3JlIExTRi9NTS4NCj4gICAg
ICAgU2luY2UgdGhpcyBpcyBhIHRvcGljIHRoYXQgaW52b2x2ZXMgc2V2ZXJhbCBwYXJ0aWVzIGFj
cm9zcyB0aGUNCj4gICAgICAgc3RhY2ssIEkgYmVsaWV2ZSB0aGF0IGEgRjJGIGNvbnZlcnNhdGlv
biB3aWxsIGhlbHAgbGF5aW5nIHRoZSBwYXRoDQo+ICAgICAgIGZvcndhcmQuDQo+IA0KPiBUaGFu
a3MsDQo+IEphdmllcg0KPiANCg0KDQotLSANCkRhbWllbiBMZSBNb2FsDQpXZXN0ZXJuIERpZ2l0
YWwgUmVzZWFyY2g=
