Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7DD56B25E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 07:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbiGHFni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 01:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbiGHFng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:43:36 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 22:43:34 PDT
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32987660;
        Thu,  7 Jul 2022 22:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657259016; x=1688795016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CZTxoSgJFBkVtxp6cFQFWGhQZC+zfRK1v3455v9X7mo=;
  b=f7PLEd2BZ/GSc0xoBmKAR/Kblo1w0SdmIUk2Zoaolh6ipycUyLOD1EfZ
   po34H+fZkT5/dydngzVrHF6N7Z+4G7Aa1iJgoUAgcrj+UwdwpPFpCwGHj
   aaxY7diNubJ54JJ55JaNusDNDxrehl4kM5/XHLhMiMZz8R02GXplzp4z5
   0Q4JCSkCA+hia3H1X3yyK2SqY9QH4aoQRaPyqtKV9LyWN0iBUA6kRz6De
   QWugBRAZzH73s8zpmmQ+4bNCT3zNG1XJMnitZwWYsHXObjYFJQolbmYSc
   YnEDX8ymmixyIg+hJrCKmdtP0rATrpX7KeT6Zn41NEPtS6v+ftQrnhbsk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="59881658"
X-IronPort-AV: E=Sophos;i="5.92,254,1650898800"; 
   d="scan'208";a="59881658"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 14:42:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1o4wpdctrScbR0k0uL67xMLV2iJdbnXzkfqXhZqhFpGModoA8i9FUcZpA6qvE6PcFed4DcpGU/i3R76n9zIU30IjZuhcA7neiUGeqF5fXqZ1M2czHZ3OEi/6hzQqUAplWlaoWouIWzXnQrc6ea/00xTrmdL3iIz6FrI8lvLRmnU/J10W7VM/65j74Tb8wsOuaxe7EBjhDtBthhdUMfbiKEfKHdHmXqXhc7fZEiLF2gdzG5D/RUazHPnt8y0+dbsdlJHWhB/unRncLgeCoDmML7QydH+b0KOrEwssaEtBweSZbEX2YIzczpviWpHA8Z80lCYetxEvPKX0PVtQelBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZTxoSgJFBkVtxp6cFQFWGhQZC+zfRK1v3455v9X7mo=;
 b=YsWK8XNaFXZVx/adh6Z9T6efrNu8kGo/xVcdWBZaRz8yPMsD53fna/5vVmBgIKugAqIzTklGK7U7HvX+O2H4DXaI6aE6qXMWqDqaAnnMim5bkldSLLf+FEYj4HrmSz24Mx4gyQjOBduqmmOyF+M+u8+AAuhqIHZgrgLsQ5a+h67/e3wKM+nCRgOztLJZuupcdsMJj1ViQJkMwiXiDCys6m2/cE+91h7RRPh4xNxlcF8TNQGKAvTPqkdvK+LW7sNGJHpEBI1dvu7OxqpHukYdzlJiZ/MGqWj9ZUG183Dm0rOc+saqUe8x+Mc6rCDzAuXQAYcHfntDOydR0zyhx1yUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZTxoSgJFBkVtxp6cFQFWGhQZC+zfRK1v3455v9X7mo=;
 b=f4bVlxTw66wAbN7SpOI0xl6h+ioQZewZLGKTBW3eyuGd0yfrbHXhjm1lWABY3ha1rhNSGUU/cjWGUC40u+6+jR/TzUB0BwNKmDiwF13xdPS3Gq0gUZvCrTXd5Mm63v5YSDUaCnXGbhBoxhBcFyIZB9vhuKN+ZBnnz93X9qq/IAg=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB6152.jpnprd01.prod.outlook.com (2603:1096:604:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 8 Jul
 2022 05:42:23 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::ece2:4ee0:93a4:ce47]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::ece2:4ee0:93a4:ce47%7]) with mapi id 15.20.5395.021; Fri, 8 Jul 2022
 05:42:23 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
Subject: [RFC PATCH v5] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Thread-Topic: [RFC PATCH v5] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Thread-Index: AQHYko1/owWb1jmYaUi3ZNl5TxAoJg==
Date:   Fri, 8 Jul 2022 05:42:22 +0000
Message-ID: <20220708054216.825004-1-ruansy.fnst@fujitsu.com>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.37.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21b4364b-3b1e-409f-8a79-08da60a4a1c4
x-ms-traffictypediagnostic: OS3PR01MB6152:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zf7CFnzd1rHgKqtSIDFo/92yrQh3qtU6ODdyzb0L51PX5w3KXzJrVA1HWj5+K6lBdNj1zMZg7t0+cG8pXvT/97t1wt5dyB2DZE+xvKN7JQNfQD0P4yv9na8skfN7aJHGQ24lkec2V8TzEgz+JxinoOPx6zIFzUsMDWMbtJHyBZWwouUIoI3uNeM1Vg1dFx4y4rB/W58Afe3/86xhtkBIf2D9iKbQviLvynZV1GxhXA/+v1kP8R/IcdlNrtAJBsW6njoSRJ7T0qZXPqPir3MVIwW/mV7Bg1SjFDrr6cZriCzx8mLIa0+D/RBpq5l6KW5qKLW4sO7j9gJ5H/en1hRe8iZ0O1mioZJ1ADvqvhbbPIcLZDWZRYM8pbm8h/FjZvwhcCnPS0JU9Gd9bNO4EIX/ak/HRWLIQWF5AUOrU9RW+hhv0SAiKGbNURMWHaMwY6A6Jq0ymB+ji4++tZhNlIFJLar4cqcNnw/r2e5Iagthq036OeNWA7OPLtvnw4/nUEhb6bCIIsOIM3oUsRI1vbS3KaLHaylPtP9t/1tnLjz12ZtQMn6WGLoFFAZG76fyQASJIoAcgRnNyJ5RCO7/T+RjMqqHV8cc0T+d+tgcD7t/YzVI4WozgVngdh7uaLEndcDWWce2qjLcZMl+QFEyIgtTa4R1f9Y9qQZjP8POubYSvJacLHyFlZGIIQ15sh7XCkVkgku5a857qR52HRQKkwQtBdmZgU+YrHaFzq1G4Thkcipmmc1sgYii8fwn8j924b1uBKe2lOKgiIJ9WmZDFQmdTGUa41XhXnFFJ3TH8/Zv42+hrOAv2mZTmUabq20iHreY4LTlwbQfThTm2hKsnJ+SQUil7VqjbAqwwPeofg/IGXOR7/HHrFxhb5tjZVI0Tqe9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(8676002)(66946007)(64756008)(66446008)(86362001)(66476007)(91956017)(7416002)(66556008)(8936002)(2906002)(4326008)(76116006)(36756003)(316002)(85182001)(82960400001)(5660300002)(110136005)(6486002)(6506007)(41300700001)(26005)(186003)(38070700005)(54906003)(966005)(71200400001)(6512007)(83380400001)(478600001)(38100700002)(1076003)(122000001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RElQRU91UzBHdDZWUGVxZzc3UUphNXJYb056VCtLYktHL3hGWmhCb2IrbVha?=
 =?gb2312?B?ZEU1MVJNbCs4NmVFamVJS2JRZ2tlY0NpWi9mMGxsQm9DSjUyR0ZuYk1FbTd5?=
 =?gb2312?B?clJUSDlnRm81YUNOMll3cmJFREpiY1NWY1lsTjR0NW5ZdnRUYlQvZ1o2YXl2?=
 =?gb2312?B?aG9qdWNaYjVyV0lGbnNTbTZzUDlqRys0RXU1NkoyOWwyRndmVWc3elZHREFP?=
 =?gb2312?B?c2VtVnFGcDVHVGxkU1BlUG05ekNMMThkc0dMa2NMQ1R4QVVEUHJlRi93ZjhZ?=
 =?gb2312?B?SHVVZ1BtWU5Kanp4eUd2MFpFdWNPS1pZWml6NHN5dDhXdlpma2xjRm9TdlBx?=
 =?gb2312?B?NWs5dGpCaTcxekY2L0Rqanlvb0xHbUhDME11YUNhdVNXRU5LdjBHeS9WSDFx?=
 =?gb2312?B?RmpLdEJrOVAybjVHMlQxWm5YeW1aYmhqVStRSGpJQjZFcXVHR2RUZ1VYMUhW?=
 =?gb2312?B?Z0t6b2FCOWI4SUdtMnppYmlteFRiRTRycWU4RDhuQW5NNXdmMFZrZ0J6bVFS?=
 =?gb2312?B?Vjg1SmdwMkhVM1RwTmlVSElGNG5vNFdkYytJNng2UDlocDBvV2RYSkRWRGhO?=
 =?gb2312?B?dHppZTVETDBZOW5GbnUxNjM1NFhHTGRWMDRFTEFvampGNjliT1RRa2VWRmJU?=
 =?gb2312?B?eUJ0eE1QbHNGZm1weldmUDlrRStOWkMzOTU1U1RQR0xHSTQwNTRUZlBDd1Ix?=
 =?gb2312?B?QTVXT29Xbk0xSDkvYWQzVDQwdHkrL2VySENZODJjWmRtZm1qYUZFcENPQjZ5?=
 =?gb2312?B?SFhXclF5NlJzSTE0RTJtTCtlYmxHTkpTY3FXbXZFMFArTUwzc2lZM1dlMnVj?=
 =?gb2312?B?cm15dERZdDlKOUZHSTlZOHpkVDlnamlyNHV3M0U2aFIvdUZMaHczSWQ0cko0?=
 =?gb2312?B?aVlWYXExbm5kR0hVYkpqWC9uMVNVRjVwTUpqb1JRMEdUV2hreFN2N1hlRGJF?=
 =?gb2312?B?aUlDVmpCZ0RjUm1EN3JKWXlFK2hsTE5OZUhiVFFyR0tQUllSOURkVlZVM1gy?=
 =?gb2312?B?ZGh1V09Jd1ZkcmM3cWJpNlo4R1I1ZjhkellQWmZQWHRoeE9KbHk5WjhnSGh2?=
 =?gb2312?B?QVZSa1NlV201cGVLMGxMWXN3VEQ4ZEFhczJUMHp1Qms2eE5WZmVGV0RNQmhI?=
 =?gb2312?B?TFR2QXlhdnV0aUsvWjBxVjNISzAya1QvUklJVVNDMys1L054aDFVbTF0MTNk?=
 =?gb2312?B?STl5QUJUc00xZWNFU01oNE9Pb3BEU0JjSUp0OTNjT0lnZy9lVDFKUU4ySW54?=
 =?gb2312?B?RHI1c2JaTkdLbXhQS0tpTWRlaEF6MVNtSkpFTzNkU2duUUVkRUtVY1B2bzhS?=
 =?gb2312?B?eXRLbG5GYWhzWVAySUwya29IeFJ2Z3lOenM4TktFNnhCQW8rWDJKUktDNmEz?=
 =?gb2312?B?dWgzMThvUll2RXFCWGJtVjgwN3MzZFpneWt4ODFBdVNaRnkxQVA3dENiUHdt?=
 =?gb2312?B?eWZpbmYza1NvbW45MkN0UStJTDUwMEhEekQ5RDJYSUNlNWZUYTBMcW1HemRH?=
 =?gb2312?B?cFhja3ZlcUlFemZ6RXFpNG9RRWhqZVlJYjM0WmRQSzRTL0dvQWRUbi9icEVH?=
 =?gb2312?B?N1RNaWI2VmhXUFZJVVNxYUpNaU81R0ppcFA5QzBvWE5mYzcycnMxZWh4amFW?=
 =?gb2312?B?SkQ0NDh0NjJkT21pbEtGNVJTSTRHcm9vbzhRMytNVkVnVTlsU3Jwc3gwK0Rs?=
 =?gb2312?B?VFhKclFtQTNzNHY1Q2FwcEZpb244bWlGcTR1WEdwL2pVMisydmlMMHBXb3pl?=
 =?gb2312?B?dCtSdmEzWnAzeXFSanpmWVdQU2JST3pYTWg2UktrVVdsZTNPa0xNcmgvVFBB?=
 =?gb2312?B?SmhDT1FNZjM1YmxzY2JVWDdnazFGczdxUElJa3E2KzEvZDgwc1hKYWFyRzFD?=
 =?gb2312?B?TUxQK2ZrMFNodm4yaW0xOUpRQWVsZkExbFY0TE9yK015ZFRUNkVWckptUldh?=
 =?gb2312?B?ZE1SMkM5eDRLRFlscVpRRnFtRm5JM1pBNDRvaHd4dkhzUWtkcjhQaGp0ckVn?=
 =?gb2312?B?Z0lNWjFxRUlhN3JqVjA5ekZ1Y3ZWM3ZtZE96SVNieXpLVUlBRlgvRmJGS3Vt?=
 =?gb2312?B?ekY1T2RBZzFBcktwOVlmSlBDM2VXU210QkZ6eWtISmJlN2hTenZ1bDJ0L3RQ?=
 =?gb2312?B?VWpxcEhDbHdTRHBYUEtvcDdkSkJWUEdJT2pyUnd1NjNtd2tqSXZqU29QYWJa?=
 =?gb2312?B?Wmc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b4364b-3b1e-409f-8a79-08da60a4a1c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 05:42:23.0636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZB9FuYNP+vA/qmhCbLXHjTyxdwVG8tAvrTf9bZYD/hVS2LlWcnVQ78EE3ClEhLFYG9V9KKjodKWC/yTcxscy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6152
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhpcyBwYXRjaCBpcyBpbnNwaXJlZCBieSBEYW4ncyAibW0sIGRheCwgcG1lbTogSW50cm9kdWNl
DQpkZXZfcGFnZW1hcF9mYWlsdXJlKCkiWzFdLiAgV2l0aCB0aGUgaGVscCBvZiBkYXhfaG9sZGVy
IGFuZA0KLT5ub3RpZnlfZmFpbHVyZSgpIG1lY2hhbmlzbSwgdGhlIHBtZW0gZHJpdmVyIGlzIGFi
bGUgdG8gYXNrIGZpbGVzeXN0ZW0NCihvciBtYXBwZWQgZGV2aWNlKSBvbiBpdCB0byB1bm1hcCBh
bGwgZmlsZXMgaW4gdXNlIGFuZCBub3RpZnkgcHJvY2Vzc2VzDQp3aG8gYXJlIHVzaW5nIHRob3Nl
IGZpbGVzLg0KDQpDYWxsIHRyYWNlOg0KdHJpZ2dlciB1bmJpbmQNCiAtPiB1bmJpbmRfc3RvcmUo
KQ0KICAtPiAuLi4gKHNraXApDQogICAtPiBkZXZyZXNfcmVsZWFzZV9hbGwoKSAgICMgd2FzIHBt
ZW0gZHJpdmVyIC0+cmVtb3ZlKCkgaW4gdjENCiAgICAtPiBraWxsX2RheCgpDQogICAgIC0+IGRh
eF9ob2xkZXJfbm90aWZ5X2ZhaWx1cmUoZGF4X2RldiwgMCwgVTY0X01BWCwgTUZfTUVNX1JFTU9W
RSkNCiAgICAgIC0+IHhmc19kYXhfbm90aWZ5X2ZhaWx1cmUoKQ0KDQpJbnRyb2R1Y2UgTUZfTUVN
X1JFTU9WRSB0byBsZXQgZmlsZXN5c3RlbSBrbm93IHRoaXMgaXMgYSByZW1vdmUgZXZlbnQuDQpT
byBkbyBub3Qgc2h1dGRvd24gZmlsZXN5c3RlbSBkaXJlY3RseSBpZiBzb21ldGhpbmcgbm90IHN1
cHBvcnRlZCwgb3IgaWYNCmZhaWx1cmUgcmFuZ2UgaW5jbHVkZXMgbWV0YWRhdGEgYXJlYS4gIE1h
a2Ugc3VyZSBhbGwgZmlsZXMgYW5kIHByb2Nlc3Nlcw0KYXJlIGhhbmRsZWQgY29ycmVjdGx5Lg0K
DQo9PQ0KQ2hhbmdlcyBzaW5jZSB2NDoNCiAgMS4gc3luY19maWxlc3lzdGVtKCkgYXQgdGhlIGJl
Z2lubmluZyB3aGVuIE1GX01FTV9SRU1PVkUNCiAgMi4gUmViYXNlZCBvbiBuZXh0LTIwMjIwNzA2
DQoNCkNoYW5nZXMgc2luY2UgdjM6DQogIDEuIEZsdXNoIGRpcnR5IGZpbGVzIGFuZCBsb2dzIHdo
ZW4gcG1lbSBpcyBhYm91dCB0byBiZSByZW1vdmVkLg0KICAyLiBSZWJhc2VkIG9uIG5leHQtMjAy
MjA3MDENCg0KQ2hhbmdlcyBzaW5jZSB2MjoNCiAgMS4gUmViYXNlZCBvbiBuZXh0LTIwMjIwNjE1
DQoNCkNoYW5nZXMgc2luY2UgdjE6DQogIDEuIERyb3AgdGhlIG5lZWRsZXNzIGNoYW5nZSBvZiBt
b3Zpbmcge2tpbGwscHV0fV9kYXgoKQ0KICAyLiBSZWJhc2VkIG9uICdbUEFUQ0hTRVRTXSB2MTQg
ZnNkYXgtcm1hcCArIHYxMSBmc2RheC1yZWZsaW5rJ1syXQ0KDQpbMV06IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LW1tLzE2MTYwNDA1MDMxNC4xNDYzNzQyLjE0MTUxNjY1MTQwMDM1Nzk1
NTcxLnN0Z2l0QGR3aWxsaWEyLWRlc2szLmFtci5jb3JwLmludGVsLmNvbS8NClsyXTogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgteGZzLzIwMjIwNTA4MTQzNjIwLjE3NzUyMTQtMS1ydWFu
c3kuZm5zdEBmdWppdHN1LmNvbS8NCg0KU2lnbmVkLW9mZi1ieTogU2hpeWFuZyBSdWFuIDxydWFu
c3kuZm5zdEBmdWppdHN1LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZGF4L3N1cGVyLmMgICAgICAgICB8
ICAyICstDQogZnMveGZzL3hmc19ub3RpZnlfZmFpbHVyZS5jIHwgMTYgKysrKysrKysrKysrKysr
Kw0KIGluY2x1ZGUvbGludXgvbW0uaCAgICAgICAgICB8ICAxICsNCiAzIGZpbGVzIGNoYW5nZWQs
IDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZGF4L3N1cGVyLmMgYi9kcml2ZXJzL2RheC9zdXBlci5jDQppbmRleCA5YjVlMmE1ZWIwYWUuLmQ0
YmM4MzE1OWQ0NiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZGF4L3N1cGVyLmMNCisrKyBiL2RyaXZl
cnMvZGF4L3N1cGVyLmMNCkBAIC0zMjMsNyArMzIzLDcgQEAgdm9pZCBraWxsX2RheChzdHJ1Y3Qg
ZGF4X2RldmljZSAqZGF4X2RldikNCiAJCXJldHVybjsNCiANCiAJaWYgKGRheF9kZXYtPmhvbGRl
cl9kYXRhICE9IE5VTEwpDQotCQlkYXhfaG9sZGVyX25vdGlmeV9mYWlsdXJlKGRheF9kZXYsIDAs
IFU2NF9NQVgsIDApOw0KKwkJZGF4X2hvbGRlcl9ub3RpZnlfZmFpbHVyZShkYXhfZGV2LCAwLCBV
NjRfTUFYLCBNRl9NRU1fUkVNT1ZFKTsNCiANCiAJY2xlYXJfYml0KERBWERFVl9BTElWRSwgJmRh
eF9kZXYtPmZsYWdzKTsNCiAJc3luY2hyb25pemVfc3JjdSgmZGF4X3NyY3UpOw0KZGlmZiAtLWdp
dCBhL2ZzL3hmcy94ZnNfbm90aWZ5X2ZhaWx1cmUuYyBiL2ZzL3hmcy94ZnNfbm90aWZ5X2ZhaWx1
cmUuYw0KaW5kZXggYWE4ZGMyN2M1OTljLi43MjhiMGMxZDBkZGYgMTAwNjQ0DQotLS0gYS9mcy94
ZnMveGZzX25vdGlmeV9mYWlsdXJlLmMNCisrKyBiL2ZzL3hmcy94ZnNfbm90aWZ5X2ZhaWx1cmUu
Yw0KQEAgLTE4LDYgKzE4LDcgQEANCiAjaW5jbHVkZSAieGZzX3JtYXBfYnRyZWUuaCINCiAjaW5j
bHVkZSAieGZzX3J0YWxsb2MuaCINCiAjaW5jbHVkZSAieGZzX3RyYW5zLmgiDQorI2luY2x1ZGUg
Inhmc19sb2cuaCINCiANCiAjaW5jbHVkZSA8bGludXgvbW0uaD4NCiAjaW5jbHVkZSA8bGludXgv
ZGF4Lmg+DQpAQCAtNzUsNiArNzYsMTAgQEAgeGZzX2RheF9mYWlsdXJlX2ZuKA0KIA0KIAlpZiAo
WEZTX1JNQVBfTk9OX0lOT0RFX09XTkVSKHJlYy0+cm1fb3duZXIpIHx8DQogCSAgICAocmVjLT5y
bV9mbGFncyAmIChYRlNfUk1BUF9BVFRSX0ZPUksgfCBYRlNfUk1BUF9CTUJUX0JMT0NLKSkpIHsN
CisJCS8qIERvIG5vdCBzaHV0ZG93biBzbyBlYXJseSB3aGVuIGRldmljZSBpcyB0byBiZSByZW1v
dmVkICovDQorCQlpZiAobm90aWZ5LT5tZl9mbGFncyAmIE1GX01FTV9SRU1PVkUpIHsNCisJCQly
ZXR1cm4gMDsNCisJCX0NCiAJCXhmc19mb3JjZV9zaHV0ZG93bihtcCwgU0hVVERPV05fQ09SUlVQ
VF9PTkRJU0spOw0KIAkJcmV0dXJuIC1FRlNDT1JSVVBURUQ7DQogCX0NCkBAIC0xNjgsNiArMTcz
LDE0IEBAIHhmc19kYXhfbm90aWZ5X2ZhaWx1cmUoDQogCXN0cnVjdCB4ZnNfbW91bnQJKm1wID0g
ZGF4X2hvbGRlcihkYXhfZGV2KTsNCiAJdTY0CQkJZGRldl9zdGFydDsNCiAJdTY0CQkJZGRldl9l
bmQ7DQorCWludAkJCWVycm9yOw0KKw0KKwlpZiAobWZfZmxhZ3MgJiBNRl9NRU1fUkVNT1ZFKSB7
DQorCQl4ZnNfaW5mbyhtcCwgImRldmljZSBpcyBhYm91dCB0byBiZSByZW1vdmVkISIpOw0KKwkJ
ZXJyb3IgPSBzeW5jX2ZpbGVzeXN0ZW0obXAtPm1fc3VwZXIpOw0KKwkJaWYgKGVycm9yKQ0KKwkJ
CXJldHVybiBlcnJvcjsNCisJfQ0KIA0KIAlpZiAoIShtcC0+bV9zYi5zYl9mbGFncyAmIFNCX0JP
Uk4pKSB7DQogCQl4ZnNfd2FybihtcCwgImZpbGVzeXN0ZW0gaXMgbm90IHJlYWR5IGZvciBub3Rp
ZnlfZmFpbHVyZSgpISIpOw0KQEAgLTE4Miw2ICsxOTUsOSBAQCB4ZnNfZGF4X25vdGlmeV9mYWls
dXJlKA0KIA0KIAlpZiAobXAtPm1fbG9nZGV2X3RhcmdwICYmIG1wLT5tX2xvZ2Rldl90YXJncC0+
YnRfZGF4ZGV2ID09IGRheF9kZXYgJiYNCiAJICAgIG1wLT5tX2xvZ2Rldl90YXJncCAhPSBtcC0+
bV9kZGV2X3RhcmdwKSB7DQorCQlpZiAobWZfZmxhZ3MgJiBNRl9NRU1fUkVNT1ZFKSB7DQorCQkJ
cmV0dXJuIDA7DQorCQl9DQogCQl4ZnNfZXJyKG1wLCAib25kaXNrIGxvZyBjb3JydXB0LCBzaHV0
dGluZyBkb3duIGZzISIpOw0KIAkJeGZzX2ZvcmNlX3NodXRkb3duKG1wLCBTSFVURE9XTl9DT1JS
VVBUX09ORElTSyk7DQogCQlyZXR1cm4gLUVGU0NPUlJVUFRFRDsNCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L21tLmggYi9pbmNsdWRlL2xpbnV4L21tLmgNCmluZGV4IDc5NGFkMTliNTdmOC4u
M2VhYjJkN2JhODg0IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tbS5oDQorKysgYi9pbmNs
dWRlL2xpbnV4L21tLmgNCkBAIC0zMjQwLDYgKzMyNDAsNyBAQCBlbnVtIG1mX2ZsYWdzIHsNCiAJ
TUZfVU5QT0lTT04gPSAxIDw8IDQsDQogCU1GX1NXX1NJTVVMQVRFRCA9IDEgPDwgNSwNCiAJTUZf
Tk9fUkVUUlkgPSAxIDw8IDYsDQorCU1GX01FTV9SRU1PVkUgPSAxIDw8IDcsDQogfTsNCiBpbnQg
bWZfZGF4X2tpbGxfcHJvY3Moc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsIHBnb2ZmX3Qg
aW5kZXgsDQogCQkgICAgICB1bnNpZ25lZCBsb25nIGNvdW50LCBpbnQgbWZfZmxhZ3MpOw0KLS0g
DQoyLjM3LjANCg==
