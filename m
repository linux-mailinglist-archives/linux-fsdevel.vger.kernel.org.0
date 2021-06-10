Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364593A29F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 13:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFJLQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 07:16:18 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94]:58940 "EHLO
        esa.hc4959-67.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhFJLQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:16:15 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jun 2021 07:16:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1623323659; x=1654859659;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jWUbJITQkbv4HUYgvWuJgZZ4eU9kQ5zlFiCaj10XH1Y=;
  b=FDocBE2PAsIQVdteNHeSd2k2GkfgmVx0R0xK+ETqAbp/mdiTi6ILBnFb
   LYQyXESSJgY5HpxtVM1fzIx8envTS4uKVD4cCpCsb9pZXXsSMYjEgXqaO
   3q/KxBv6O2ED5CWKa0mf/l2P0xeSs70osoUgxlvmqbqav1fGBMWMh11sN
   8=;
IronPort-SDR: Noq9T0NsKNrQ4LItwQOwZWZrcap5q5km/QjQcap6kMEFHyGBoZrumv5kw659laqK/QMgtgab4R
 r1JuAQ7JgtNwggKzMua8FBXurdyJk49ovEu4OxyVGXjsSQCZ9RrBRZbo+hBWd8h6HCqDwAFnSc
 eI3FShZ7R+1kOPHKgfilmnAOEGXmahmqMxLErKBgNgQtZMw9QIeezrh7zskHJHzBNdMHZuu9/N
 9NhbkVfk4hY7bHSQ9FyqG3cW5w7f0p47n7IGXaAFuu0Dnpw7OiY+nLnx4cauJvUV6flERyFCmJ
 qs4=
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 04:07:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di4x9AhEB/7sB25tsSGeHI4wALTYreYCD0VdQ7pULL4c/mmVy52z3WnJwyyzOwYXbxrHxoH6EGbBO04z/oLTCkCPUphG1P8qttvlg0N8tlUNfLAiacwr6sIZQ6uaWMxXMd+c1EdArdBnN7L3Tek1hZ5GifUbg3kp18LyzK10giHDkyWOINV/fnZSd2XKvInrydCKAn6BeEjbDPVZTCMxKaLf987Uw6fPaiEBGqhAtOENhjg2Is4oBKjPV8JpDBNdefqATBMDzfREC1njPOI+KWdhazcULWC2pH2by0SDX1Rd/JQ2DesN56RHK5lytHIs270/9yYGdYiQ14Frktfe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWUbJITQkbv4HUYgvWuJgZZ4eU9kQ5zlFiCaj10XH1Y=;
 b=A1twzpiJEJgnc8DXGIF1vPzalHcG+67G1SzF4fqdCsHnSLH3iqi7I9d4/l9jC+Zp5RCGzFlDs08cisp/ZBhSvgmDZyJYjY1pSVMVUXd0ocQV5TLulYZjJmEnMOIJKC5f+uZ9L1BfHr/Rm4CLpROzYEEODbt4rUQVcuMQAk+Uncgud85ZuVcl/f742s5AWYQWHzMeSc9aAmPHT4pWMjam8wSUfOtP53v8/ojn+rUPxthWT6rPl9AvSkbhQw4rypbyeRoVCOIdvYilqGm/3NYLY8vTFciQdZvVcNoTKaHPTaC6fod6ahs6+mpyR/H3yQw21ZuvMOk1yzkjOmbGPQFPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWUbJITQkbv4HUYgvWuJgZZ4eU9kQ5zlFiCaj10XH1Y=;
 b=WLED/Hna2xBennVS5kJxw9TPUeeKwD5O57XIA+QoA3ItCtU43t417qdJ+lEq6G8dOewPqPh3yAIqLXwG0h9MojNrmqkdNr1VRxo3aUyl29m5YOtadp1UsHyjw0BHrDbfTYsYw+nNjQSL2Oug1AkVJeJW2KZPatpgm9ndZRNPPCk=
Received: from BN6PR2001MB0979.namprd20.prod.outlook.com
 (2603:10b6:404:af::13) by BN6PR20MB1219.namprd20.prod.outlook.com
 (2603:10b6:404:88::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 11:07:09 +0000
Received: from BN6PR2001MB0979.namprd20.prod.outlook.com
 ([fe80::d180:59f2:f359:4f49]) by BN6PR2001MB0979.namprd20.prod.outlook.com
 ([fe80::d180:59f2:f359:4f49%8]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 11:07:09 +0000
From:   Tim Walker <tim.t.walker@seagate.com>
To:     Ric Wheeler <ricwheeler@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
Thread-Topic: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
Thread-Index: AQHXXR24nwc6Kq/CbE2x3x2srcjo7asL+csAgAAG8QCAAATJAIAAbeMAgABg0AA=
Date:   Thu, 10 Jun 2021 11:07:09 +0000
Message-ID: <45A42D25-FB2A-43EB-8123-9F7B25590018@seagate.com>
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
 <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
 <YMEItMNXG2bHgJE+@casper.infradead.org>
 <e9eaf87d-5c04-8974-4f0f-0fc9bac9a3b1@acm.org>
 <e191c791-4646-bf47-0435-5b0d665eca89@gmail.com>
In-Reply-To: <e191c791-4646-bf47-0435-5b0d665eca89@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=seagate.com;
x-originating-ip: [174.58.199.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 051ab0db-3232-451f-a397-08d92bffe441
x-ms-traffictypediagnostic: BN6PR20MB1219:
x-microsoft-antispam-prvs: <BN6PR20MB1219082D19EA14C585370885D7359@BN6PR20MB1219.namprd20.prod.outlook.com>
stx-hosted-ironport-oubound: True
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gti7/Oh63We+a7T1+LE37wHr/xxBzVUQqtw+W5HGfhUL00jy4CdChh6LtjsIqdekt7ABy67+JoLZEt1rVvF6B3vXq2UwUNh7y3sdXBb5nk1/kb3yOafDTOO7XwtTJwYfwl0BFsFW2VNxYqW8G1RD7xVLjmzBjrbJufE6TDDZ5FQ4wDlvWvo+2JEaef3ANX2zXyaJQCZOvFeocyJ4bzR6MAqp7oKqhsPaqsmWLIq4XCTJrYYWCcoUTdUtnphLRKxM5LlhudHkZjyfXlAwaPVLmXc77Rcbcujg2Gdh4ynVdwQMN+BPelVJjQj0VuCjafaGukIuC+x7aGWRWlq3wtjsl+OMl/53isXtIpSZl3ywolaYCAtaMHNuych+8hWvJXjLFeHvbYS4dPrFB9HyP9ve56B9GyTkxZkT6IgW8wsFy77tmSg/DZigcpjEgNmGEW3bVPaYZwMuL4Gp9GA494XMZ3xjRc3HGjY+4/JFzruz/37UWlUr3a11siKCUWXXpS0gRE0SEPyEl+HTSteCg0YU+CslG/sZ3pRJfnF5nZSpruEsMc3gRLxu8STSc8rDwITnS3zblB3peNhLQbLbsUQSiRvGcpfpwrBHupjrtcl4qpAEto9GNFXYzjfsgLxqwrkfgQfsdB2SBaDh7omWNbLCGC8q8dUczeThZl2+xd7P8I0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR2001MB0979.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(39860400002)(366004)(136003)(71200400001)(38100700002)(122000001)(110136005)(6512007)(86362001)(64756008)(91956017)(4326008)(33656002)(26005)(186003)(2906002)(66476007)(66946007)(66446008)(6486002)(76116006)(66556008)(53546011)(8676002)(316002)(6506007)(8936002)(54906003)(5660300002)(478600001)(83380400001)(36756003)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkVmSytEU3B6ZE1odHNIcm8vNlJ3Wmcxa1FPeWlLbWxnTCt1azVIYk85SXVj?=
 =?utf-8?B?bjNDRU5OeXJxeU5xNUZ2WHJMclVwd203N1hZdHpzM2hqRVZFU05GVE81aU1x?=
 =?utf-8?B?aFFNbG84aGwzK1NIQlpFWkRnVDFJbXpUWUsyUEQzeVZ5bUR5Q2dZNTJLeGtX?=
 =?utf-8?B?S01VTmIvbTg0ZklkRlc4ZTl5b3hOR0grbVgrUFROUmM0bFl6dHpPd3dsTzc3?=
 =?utf-8?B?aHpYdTVKUEdXbUNGamI0Z05HaHp5N1ZWVlhITTdXL2VZdENtbGNPSEt4SWwv?=
 =?utf-8?B?N0E5NXprWVFQQjBTa0h1NHRQT2swZzdZQkNpbHVZdEhCVUJvNlFYUm5IdnVX?=
 =?utf-8?B?cjRKQStXTCtlb09ueXYrem96R2dHQkNWNWRzVGllNnhCNTdaR1A1blo2NEJa?=
 =?utf-8?B?RzBqNFNFdVpzWm9jSEtXaExRS3hEM0p2UVNsWHJRaThKZzRHZ3ErTEQ0bmhp?=
 =?utf-8?B?dWpDRlpsa0NJSUpVVjV6NzVJcjVxeGErL2JrOGZpaWVDcmtieitTK2tjTVpW?=
 =?utf-8?B?R2o2bWtFRjhUOUY2UUZEZlJFcUVUeG8vMUJPUDJjNTdmTVJkYUNSVVp3eG9Y?=
 =?utf-8?B?K01kYVlKTUVBRVhWbUliRlRNdlBrdWdaNEdLR2JUWG1hTTBKMnpMckVCNXFK?=
 =?utf-8?B?by9Lc1paSDdwalI5MUxmdzJhb1h4TnpGS2FCck9kNnM2eFhQMktldUFWL2t1?=
 =?utf-8?B?SXl0TG1hWnRBNVBNNXRZVS9xaWlVMU0ra1Y1VlZQQmFjUWFGZmNoQ205a2Fu?=
 =?utf-8?B?RDduQjgrbkVEUFV1M1FIK3NUaWVqa2ZNOFpsOXplUlZlVzFCcmFFdktNZzU1?=
 =?utf-8?B?Z2lGa2RFbGd3SEZxWWtvR013MHRiOFpGZURob0NGMGxlQVNRamVlQ1kzT0xo?=
 =?utf-8?B?OFpCdEdYOFdYcUhRWklhUFAxZ2dNaFZpRWhINGlqOTVaTW5pRjZHZWJnVTFE?=
 =?utf-8?B?UUNkSEp6VmI0bG82VWFweENpdSt2T1llT1M3Q0M4OGYrZWVFVlgwUXU1aDhl?=
 =?utf-8?B?ejJhT0tYUUZFUitLcWROMy9WTFB0bkN2L3JEVGVzVDFuTzM5TUhtZXpBdkQr?=
 =?utf-8?B?VGxqSG5SdjJhRTRLdEh5UFM2Y2pEZklVRHN5SHZZclRiaDlBcU9EWUtoWUtC?=
 =?utf-8?B?eVhKenNjenZhVTExMVE2N0pvSkoxcU5ZS0lXRHMzWndROERBZVpGSGMxQm9t?=
 =?utf-8?B?SG91bnNNZXp2YUN3WTBLbmFIeGtqdmtKMWdRRnQwb0JxUFVwYmEvTEE3N1pa?=
 =?utf-8?B?bWFHR2dUOVQ2MVF0U0lwSTBoRWlxWDBLSnJIbDc1QXVZa0ZpdHdJK21pOVJl?=
 =?utf-8?B?Q1F1L25WRVNVSk4wdGlVYzU2RlVXVVRjblcwQ1I4emlDWEJYUTI0TG1lZWZI?=
 =?utf-8?B?cnREV1VRMHBDYURsS0pLbkdTVDcybEdXRUFybW55RkVKN0p5Z05RdnZjV01o?=
 =?utf-8?B?bWZMNnN0THNBcWUvWjZzVy9iL2JybUNuWVdMUUhYWWQwcS9LZEplWFBBbFpr?=
 =?utf-8?B?NEVwdXRwNDduV2VBWHlyVUpidE84b3ZLcGFXdk1lZWNJU0huMG9acnQwR1h6?=
 =?utf-8?B?VDFCWTg3cHF1QXh5OEdOZ3U0V1Z4OGpFdGYyaC94MThkZldTRzZaeDR0OUQw?=
 =?utf-8?B?cjd0QXcrVTJVaTlDWVVIU1FzRlhyN1JTYmVYZ3VpOXp1cER5SnNad3VXeXhr?=
 =?utf-8?B?cGhqc2Q1TGNmaktjNUZtV012aThTMUFBTit0Z3pnalJZRmFhZ3loTGdmQmls?=
 =?utf-8?B?TW40YnhqQUozM2U1NFk3TG1TVkdqMjdNTzUxRkNSc0d1cStQODBUVjFyUTBK?=
 =?utf-8?B?UUI1ZnlOaEJNMUpZZlpkZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <968B63C9F0A2354E9B2B469AF032E546@namprd20.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR2001MB0979.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051ab0db-3232-451f-a397-08d92bffe441
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 11:07:09.3978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07dSNwqEKxrtWBYaT5OamFLBWknDxR0+3fvysnxqQ4zRejX/Z1/jTkL6hMu5Ea0tu3nm/r3wyQicdiANxrSQbHu6RCeFDk0RFF16jSYfRiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR20MB1219
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgYWxsLQ0KDQrvu79PbiAgV2VkbmVzZGF5LCBKdW5lIDksIDIwMjEgYXQgOToyMDo1MiBQTSBS
aWMgV2hlZWxlciB3cm90ZToNCg0KPk9uIDYvOS8yMSAyOjQ3IFBNLCBCYXJ0IFZhbiBBc3NjaGUg
d3JvdGU6DQo+PiBPbiA2LzkvMjEgMTE6MzAgQU0sIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPj4+
IG1heWJlIHlvdSBzaG91bGQgcmVhZCB0aGUgcGFwZXIuDQo+Pj4NCj4+PiAiIFRoaXNjb21wYXJp
c29uIGRlbW9uc3RyYXRlcyB0aGF0IHVzaW5nIEYyRlMsIGEgZmxhc2gtZnJpZW5kbHkgZmlsZQ0K
Pj4+IHN5cy10ZW0sIGRvZXMgbm90IG1pdGlnYXRlIHRoZSB3ZWFyLW91dCBwcm9ibGVtLCBleGNl
cHQgaW5hc211Y2ggYXNpdA0KPj4+IGluYWR2ZXJ0ZW50bHkgcmF0ZSBsaW1pdHNhbGxJL08gdG8g
dGhlIGRldmljZSINCj4+IEl0IHNlZW1zIGxpa2UgbXkgZW1haWwgd2FzIG5vdCBjbGVhciBlbm91
Z2g/IFdoYXQgSSB0cmllZCB0byBtYWtlIGNsZWFyDQo+PiBpcyB0aGF0IEkgdGhpbmsgdGhhdCB0
aGVyZSBpcyBubyB3YXkgdG8gc29sdmUgdGhlIGZsYXNoIHdlYXIgaXNzdWUgd2l0aA0KPj4gdGhl
IHRyYWRpdGlvbmFsIGJsb2NrIGludGVyZmFjZS4gSSB0aGluayB0aGF0IEYyRlMgaW4gY29tYmlu
YXRpb24gd2l0aA0KPj4gdGhlIHpvbmUgaW50ZXJmYWNlIGlzIGFuIGVmZmVjdGl2ZSBzb2x1dGlv
bi4NCj4+DQo+PiBXaGF0IGlzIGFsc28gcmVsZXZhbnQgaW4gdGhpcyBjb250ZXh0IGlzIHRoYXQg
dGhlICJGbGFzaCBkcml2ZSBsaWZlc3Bhbg0KPj4gaXMgYSBwcm9ibGVtIiBwYXBlciB3YXMgcHVi
bGlzaGVkIGluIDIwMTcuIEkgdGhpbmsgdGhhdCB0aGUgZmlyc3QNCj4+IGNvbW1lcmNpYWwgU1NE
cyB3aXRoIGEgem9uZSBpbnRlcmZhY2UgYmVjYW1lIGF2YWlsYWJsZSBhdCBhIGxhdGVyIHRpbWUN
Cj4+IChzdW1tZXIgb2YgMjAyMD8pLg0KPj4NCj4+IEJhcnQuDQo+DQo+SnVzdCB0byBhZGRyZXNz
IHRoZSB6b25lIGludGVyZmFjZSBzdXBwb3J0LCBpdCB1bmZvcnR1bmF0ZWx5IHRha2VzIGEgdmVy
eSBsb25nIA0KPnRpbWUgdG8gbWFrZSBpdCBkb3duIGludG8gdGhlIHdvcmxkIG9mIGVtYmVkZGVk
IHBhcnRzIChlbW1jIGlzIHN1cGVyIGNvbW1vbiBhbmQgDQo+dmVyeSBwcmltaXRpdmUgZm9yIGV4
YW1wbGUpLiBVRlMgcGFydHMgYXJlIGluIGhpZ2hlciBlbmQgZGV2aWNlcywgaGF2ZSBub3QgaGFk
IGEgDQo+Y2hhbmNlIHRvIGxvb2sgYXQgd2hhdCB0aGV5IG9mZmVyLg0KPg0KPlJpYw0KPg0KPg0K
Pg0KDQpGb3Igem9uZWQgYmxvY2sgZGV2aWNlcywgcGFydGljdWxhcmx5IHRoZSBzZXF1ZW50aWFs
IHdyaXRlIHpvbmVzLCBtYXliZSBpdCBtYWtlcyBtb3JlIHNlbnNlIGZvciB0aGUgZGV2aWNlIHRv
IG1hbmFnZSB3ZWFyIGxldmVsaW5nIG9uIGEgem9uZS1ieS16b25lIGJhc2lzLiBJdCBzZWVtcyBs
aWtlIGl0IGNvdWxkIGJlIHByZXR0eSBlYXN5IGZvciBhIGRldmljZSB0byBkZWNpZGUgd2hpY2gg
aGVhZC9kaWUgdG8gc2VsZWN0IGZvciBhIGdpdmVuIHpvbmUgd2hlbiB0aGUgem9uZSBpcyBpbml0
aWFsbHkgb3BlbmVkIGFmdGVyIHRoZSBsYXN0IHJlc2V0IHdyaXRlIHBvaW50ZXIuDQoNCkJlc3Qg
cmVnYXJkcywNCi1UaW0NCg0KDQo=
