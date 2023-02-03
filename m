Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF6E68982A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 12:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjBCL5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 06:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBCL5W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:57:22 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1A45A37B;
        Fri,  3 Feb 2023 03:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675425441; x=1706961441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=48PWf/niqBJL/X9aJVaShOIskhmkcK2J7wK8/pmuqO0=;
  b=IX3jUpjKGAgJOQ+44HtkrDnRKUXHoosy2Hhsagn7RLW/kqhHh9K9TAJY
   CtjEApbGhCmvJ153SYWQiT8RfooGhOzFjbsb3mO508Wr0lrA4rd+sCbA6
   UOd1uolcEnFinGXrpYa3qEXIrNZbMy2cUYhNoVn4MtJq/8QNPDVYSakKk
   3Mh1Bdetast0b41SCNPL8yXo/LGOEPnlnn8S44H7ajiuqeZjrNVyybIxD
   HNxJ2pHRTQ0iVXyXUEtqPhKgUslxoJveURnTsOCNLafCl42MRBML+piId
   z3AxQCdBwAM1za/+kmOKKZIIRWSwT5843hWCvZ6TnzHZbcFV7VPyKpXWE
   g==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669046400"; 
   d="scan'208";a="222496033"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2023 19:57:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RASPkKPMJk9FJ9b+R7ymHZQfmUgh0ZhIY+MwaBIZCVdnfy5JKIF3o553lYIXj2TKEY1kl5JUPppr8w4cyf8kR5/1FRU7liV/qdVdScs5/7MnIVS+R9q6XO/PootH1IswWoCR5C2r47RCkf1GAXNkOpiA95a8OoRvmks2xShT5LRFNeCX3zHPAupY4D9b7G8rOVi35MqJ9iuL8qL9NRtppPKM+iS74K9jnREeTdY3XSDHAZUK9rSuGkvuTwMED1tJL3VTIvphv2sxG1TFmZvEEl++FpACxZUx7//W97ap4X3oLp69agFFtuFZYU3DN2vBvqpoQoh2XFz26zh4IRiXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48PWf/niqBJL/X9aJVaShOIskhmkcK2J7wK8/pmuqO0=;
 b=b4wBQ6Arhpap3mQ31DNrV8b6kWv+lYuQzX5aywHFkTCPj79pWsXrS2dVtCytA9Txu2Wt1JLPD0o8EdstaGDjstRfGe239o6FgxqBBRFx3HtFsMWend0nGn9sEKmCLTdZC+vzElLEJuAi1BCaxqX4PD1N26pq6VSmMHNx+TI7d9uMpIRBY0QxojJn3PbY7JYvEAuxiJnnWWzBZ6Tcx01lmbvOSbZ/+6bNjULS+R4OgJbFkmvG1vHdL+4eQPOTTIwuk21/6Qf8YwcpcrZjbwIIj0Dx8P80qmCCIlZNPL+de+q19U2iEu4IpC9k2C+w0AkJHwXOGMkTt5rY5qG/mWXMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48PWf/niqBJL/X9aJVaShOIskhmkcK2J7wK8/pmuqO0=;
 b=Tg44YD/o+kpPtgIfOODTU8vtVxss9mU5cFQOaDwE45fxkvsNOA44WWpnWhYXSzU/HgBFE5jcJttf7TnF6gIstbM/4XvPBtopkoEXKEjlsbkv/RBp/9SQaEDpIMBRZX+LW2SdH4NVN1jy5BLLCQYnzMueptn631Hr94w438zI1UE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7904.namprd04.prod.outlook.com (2603:10b6:a03:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 11:57:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6064.029; Fri, 3 Feb 2023
 11:57:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hugh Dickins <hughd@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH 6/5] generic: test ftruncate zeroes bytes after EOF
Thread-Topic: [PATCH 6/5] generic: test ftruncate zeroes bytes after EOF
Thread-Index: AQHZN0dIeWBU9jWwBkykqvME6fAYG669HrsA
Date:   Fri, 3 Feb 2023 11:57:11 +0000
Message-ID: <ae8067b4-37ef-a1ea-5cec-ee8e55c101fb@wdc.com>
References: <20230202204428.3267832-1-willy@infradead.org>
 <20230202204428.3267832-7-willy@infradead.org>
In-Reply-To: <20230202204428.3267832-7-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7904:EE_
x-ms-office365-filtering-correlation-id: eeb0fef8-0d1f-4824-d8ee-08db05ddc8aa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZD/Z7XJwQ/yOzYc2qi9ADkXUR3w+dmGbB8pGxvSDmESHqnK6TFHqHk4Mpn1ispAPSyYmAfyCf3De3TNugs5O/8zw4ck7r5Hxvc+dPx4cM2KPf9gOkCH5IGb70E7lBSUuuuLW5ayuPVKBCsm1jfwYFyPjtu2wznYswgtg61oqK9M87Zant+U2qffqKvQeYSZdY7g/T4ny8c+VdvMKcd/cVxzi87+V+WVpk4OOK8WBbfN0ujubcOO2ART8ujqkDEA7xAEkubjl4oMoluU9nJK6BYKkSqEeAW4ie5OyNbOLFV56fX2pfuDBLN1T4f5FxAr/PLk6WN4BzoANsjNIHug9hhUM9yKAoyorvz/EOhpaJhyRpGXlhtY6M85dZGjebvxb9zqc/JIpDw0R8J/uqZBaDSvZl5w7aCXeWAbMtOH5w1s6DlYA2BTOHvEiiKf6ofp6Dc3lKSCXgnsDRWiZbrtZnxP/znCUCjeX3QOd6RCNsPSK4lidjy/Lh7GuyntcCeTk9FaqxUVYOqthZzCx9jY31wtwJWtUDQOgfwu86iUn2ZR6IsgLdM83l38nzjVO0iBSkiqwvCJ4G0ltR22HoRMXe9PNyCr7hkry+11+zFPbuimVP0KJN6lMPS5PSnETKizA8igR7GFdEjx7SBVfXUol7llX9DzrG3RrPGU6kDEMjjHLJaxhcFbYfl0vHw6zvOCQW7H4YUmlkX27cwIhEqhTtZrieXJF/GVKkPlY7MAHsUaf4xYURKGHbleoL2CepE8amFK+6hJk45E10m8HP0oV0DuGEOyp1Q7lbLYx5OX9HRc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199018)(2616005)(38070700005)(38100700002)(122000001)(83380400001)(26005)(6512007)(36756003)(6486002)(186003)(31686004)(478600001)(86362001)(6506007)(53546011)(82960400001)(31696002)(71200400001)(8676002)(54906003)(110136005)(316002)(64756008)(66946007)(66476007)(66556008)(91956017)(66446008)(4326008)(76116006)(41300700001)(8936002)(5660300002)(4744005)(2906002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2NyVEhEYTU1NElXNkVURndSRkdrQXh1WUc0VmZ0ZGY5SEJpRUNTOFNVMm9W?=
 =?utf-8?B?emFCRXMvaDdpdll0NEx1SmNtUmw5NWJvR3JYZ1BUeENzZTRHZzhtaldUTENK?=
 =?utf-8?B?a0Z5TkhSMmtJYXJDbkZYd2NwZEJIamRlSllPbExiNU1uWlA5Y01CRm1RcXZ3?=
 =?utf-8?B?MmkyVWFRN1lJRHBiY0NaR01HVFd1bUFpQ0wyRnl5K1BybEhUdUp4OFQzOUxi?=
 =?utf-8?B?Vzl4bElsczM1Mis3S0Q4dE84emh1SENSVEx1ZjdSb2RzRnQ4RXNMeXFtZU12?=
 =?utf-8?B?THJuM0RLVHBHMUNLRC8wVWpjU05xUnVJSWxxblZ0WVdnUHJjeVpEdzZHaFNK?=
 =?utf-8?B?aVJxT3BOMDY2WVdXWW1iZlgvYVorV1VJdXc0eTBBdkVMR3JiQXM5Y1RSZmt0?=
 =?utf-8?B?V2Y1SG9ZK0VOWnJhdktES1duS2p6M3FXZW9TVTBzWEx6c2M3M05BUG5YQ1RL?=
 =?utf-8?B?M0JwL3BhQmF0cHg1WDV1Rlk0Z3Q1eG1obFV0MGdnOFcwN3A5b09RaktaTnJF?=
 =?utf-8?B?WmpnZDdjRnBMVmhCWHZHUU9WUGN5M1RGT0FhdVNsOEVMYWtZWTRxZFJ6bGlU?=
 =?utf-8?B?cnNScmloZ05oOWQyby9yTisvRjBYaTdGK2hiRzRzMk1wKy9HbUdjUzNIUmlE?=
 =?utf-8?B?cU1BYWU5cDZmNHUyNFZVVG9UK0w3Rkg5Y0xWOE10aTZnQlhtcGp5dVFuSkJr?=
 =?utf-8?B?eCtIWHFWNXFVOWN4NEtvQURLK2JrVDVRK1VmRUNxd01KTnpjYVZoemMyNjQ5?=
 =?utf-8?B?dzVwTU9ZTWpnZHlwRFZFVE5hWjZIRUViZlVRbkhzM2hVWVgvU2lrenpCWFMx?=
 =?utf-8?B?TDBZS0Q4TFNrR0ZFdUNrSitaMFloQk42b3pTNDVvcS9ld3JIMWY0ekZuVXBW?=
 =?utf-8?B?VXBFSy9rdDNIdU1nNUZhaFFjTUZCRVhINlFIU0FEbEx4UTJ4b1d2S3NnNTc3?=
 =?utf-8?B?N3BGR1BSRDZiclhNNE9JN3lCWnFPUEpPTlNneW10UGo0S1pUT3pMTUh5UjVC?=
 =?utf-8?B?WWQ4YnFxVm5PUm9zRDdDMTR1ME1TbjRJVE5ZODBkU1Z6N2xUMWVtdGVvSEto?=
 =?utf-8?B?cXFMVEFqMlVRSnkwNFNkOU5KeUxoQnJsaGYvN1lZY0hRaVN0OVpUOFNwbUxp?=
 =?utf-8?B?ZXllelRBQkgrRW9sOWQ2WXBWZkFxZkFWbU13ZlkxdzV1bzZ3dTQvQm4rMk9Y?=
 =?utf-8?B?UVFVaHRqalZsRTRUNXlhVHdTa1R4alVsZDdIZmxZWi9aSXdnL3BiMStMclVG?=
 =?utf-8?B?VzR6Tjh6T2tRL0dtWlFwQmljM3Joa0ZoelJrb0JRMmJNVERsQWZ4THI1aHVN?=
 =?utf-8?B?SDFpdk1sSHBvNFJhRDlGR2RnblQ5eHZ6Q0N5ZzRhdlJYaU5WV0RSZDhRNW45?=
 =?utf-8?B?STVDa1FQbkY2NFBPSmUzSmQ0UmZIYThpVzJoR0dzSkpiTE03ZHJFZVR0NGtV?=
 =?utf-8?B?UDVGWThjM3BFb2N3UkJuTXdMTWhwMUJWamNQcWZpbVBxdFlESkx3eHFPU1Q1?=
 =?utf-8?B?bG9LR3ZDeG5vV0hFNXRjUm9BZjl5YkpibEJQUi9oMkdOdzlna0hQUWRuQjQ2?=
 =?utf-8?B?dXFJTjNzbk9waStDVjMyQllVNU1aaW91MDltUURveldISzJzMHhUQ2ltNFdL?=
 =?utf-8?B?NkM4Mzc5Vk9NNTZVc2dpemFTZnBCZUQvVFIzMEgrTjBsMSs0RThOeVJaOXlV?=
 =?utf-8?B?T2Z3UFNVVCs4b2w3SFBtQkJDVmtPOWdOaFFuL2xrdzlSZlo2UTdtWDJFNno1?=
 =?utf-8?B?VU9Hd3NrWVR0aVMrV1ZDNVA4MnhZUDY0UUpIUjdBbDM0MkxXMWg2S3l2RUNT?=
 =?utf-8?B?OXhzRnlUUGJvaWVsQmpZMWhVQjZycytXTktsTkpZTlRzTUZ6cGV4WmZZWm40?=
 =?utf-8?B?QU5iU1pwM0FYMHQ1aGhnak1HNWZoa3RPdkJheEtRUkI4b0I1aHAyU3dCaGlZ?=
 =?utf-8?B?MGJFeTkrNHo0YWFYYVBOVGhtQ04zSTJLRDVyNllSZU5LSHBPUzVjaXIvWjBX?=
 =?utf-8?B?eHJkaTFxZ3pQeUJZWWZyWGdnVGFEbi9rdlNuaGhmSENzY2lnSU5VMEVPV1dJ?=
 =?utf-8?B?U2xsYThuQWk3MkVpTmI4aDQwZ01LeWxRa2FiRkI2ZGYvV21wQ0t1SE9tMWRk?=
 =?utf-8?B?eHV2S0tsUndzalpwM2pFVWhLWEVrWE52NkcwRnpzU0hvd0dGUjM4Y0FIZFpa?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05DA02E70837EB42963D47B1487CCC3F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cLayQgqZh0TySP7sYSwYCRcrzp1eh1uIweO1ue9mJXKrV60sonwXH3Sij4ub0O9rwIAAoNiC4DnxvXx9bv+YrGHJJ0QtxlXdm4+Nat/TSr7VjGqDeFBPKUuUrIKv7JmVcIx80UL6Rnbbe9Z9WrFcnT/EKXs0T4rYw8Db+e0HLWkoNLYefrGPaaMVpQRLst1bFv+2UBY7RB3DQnFyVjsZ4w2upsKeGRpsAX67dXEbLZ4YQOpyJDV0RsKSFYDLbD47tOWfzFsZ4pT7sPZH4LyeSROQfdtGIE7XOWlBe7Yygj+rEXiXR9oIU8/iS9FZ57DCF2zplP8r+BOCvksJtVMvJH/dLuBBY6q2x+cpylNDv3/fjHhoRSbIiF3HplPAiZCRS1dWlIjJDb8VGTQXvS2AaDB1E8C9CXzg5w2mRMDYrsVrAso7YSt46eR8Xg1kwK+D7REUWLx2H6YDpOC+4s60gE661qkLhWwh79yuFBq9q9s9SBj9OtgWin9FQyfmOvuxlI3AluiLgHICbV9Jq9bwRbGGA+Xi57JuewIwfvflRiFMC0ZaJjVUw8SsjX7wG6nTsiVJQKsUacjF+Xo57t9z1Hy0wCGNFgciU1lxxYqyZIQtV/nYr++dN4aeK0c+UFjm7fYRhzZUu/5VaPuj/jK1XlLtHTCuUaNWBbCcu1jG1/L2TcXrTQ8LTs/OGa7wI/NV4zPGDQbIxEDaXJAkfls6QeBVpiQyCSiF90OtPqPVV03YMuXACg2WBe77YxJSd6sj8otUY9ojgBahhJTiUR7wvyGGy3awy9UNCtikhlABgNhlumY98+0cnDXNrXhxQq9H1v9xk88ExQkl3iLm8Uj6mZALNTRNYydo+UlpViw5F4nl5+zieGESsaRhxNa+6VgzEAcADVYQsKw6dd/otqZN97VE10kgSMGTBN4Cy0Okk28=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb0fef8-0d1f-4824-d8ee-08db05ddc8aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 11:57:11.5295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivmpBx4JX3F538+0GzZYujZDGpErLiDJw4x8qbg+DakteFOTrULbpWJA+NE8X+h+skwUPWDiMT2Xj1UU5OVFhCAcK2+9YFYb8d5t+lyQgP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7904
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMDIuMDIuMjMgMjE6NDUsIE1hdHRoZXcgV2lsY294IChPcmFjbGUpIHdyb3RlOg0KPiArCWZw
cmludGYoc3RkZXJyLCAiVHJ1bmNhdGlvbiBkaWQgbm90IHplcm8gbmV3IGJ5dGVzOlxuIik7DQo+
ICsJZm9yIChpID0gMDsgaSA8IDU7IGkrKykNCj4gKwkJZnByaW50ZihzdGRlcnIsICIlI3ggIiwg
YnVmW2ldKTsNCj4gKwlmcHV0YygnXG4nLCBzdGRlcnIpOw0KPg0KDQpbLi4uXQ0KDQo+ICsNCj4g
KyRoZXJlL3NyYy90cnVuY2F0ZS16ZXJvICR0ZXN0X2ZpbGUgPiAkc2VxcmVzLmZ1bGwgMj4mMSB8
fA0KPiArCV9mYWlsICJ0cnVuY2F0ZSB6ZXJvIGZhaWxlZCEiDQo+ICsNCklzICdfZmFpbCcgcmVh
bGx5IG5lZWRlZCBoZXJlPyB0cnVuY2F0ZS16ZXJvIHdpbGwgc3BpdCBvdXQgYW4gZXJyb3IgbWVz
c2FnZQ0KaW4gY2FzZSB0aGUgdHJ1bmNhdGlvbiBkb2Vzbid0IHdvcmsuDQoNCg0K
