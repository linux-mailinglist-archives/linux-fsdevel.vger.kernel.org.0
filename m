Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7593129C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 05:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBHEfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 23:35:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:53885 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhBHEf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 23:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612758929; x=1644294929;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zTaxcF5EEI246o/4sIt7EdlSq6PHq/o4qUCeXkaMI2I=;
  b=NrhUEWSk+xN5/oCbtV7z9IDzVxxWULvsq68ZluN+izQ8HUaWA8M2KV6C
   cvvpAMUTfjrNet2DvmOKgYLxOMZOx1eBQIFxQUGC5n9yCwbIob14UpB1m
   nZQelA7/OFibLU1VUR3i/mIDYJHksgyUu0wEcPctGvYf6MLRFu0CekZ1Q
   3jBeN7IOuC2mL3ZwhyD9HgPW90fAjUA3FkPTMVCm+V4iRE5lYZB+l0f8i
   IuzYlA+27B4o4MfHjIAy3JCLsavpAxfBQarTThmxDlBU87/KTuHdN9xcL
   VSTWF2LNingPz9t2khpAvTkuWKEGzFkKUUqcgqRLqZ1zDn5X49xjn/Mjz
   g==;
IronPort-SDR: F7NBhpAmhDn2ybnZEP1dJskilxHK117aWJfcwXROLCicRbltFtoNwnY8LTD/62UuBRmurCZdng
 7ak57Zg28BpOrjrWm72yoi6hhaCTFqdAeiVfxMPqdolD1DoI9zcC3tdXa2WRKtRGGxSEOhzTZh
 kLz4QgF/vFGvRNBJiM9zck3QOJKYBTATrcCo36P9COnH9Tn1v2GZr5tvvOcyYN39bQRH+of+Ux
 NwNnUeTfYDIjeColdNE9RUO73tu9iTCXXEnajwNqjcrDDbHpDADnIQvhVvgWhPCMRmwgT1A7rL
 5+w=
X-IronPort-AV: E=Sophos;i="5.81,161,1610380800"; 
   d="scan'208";a="163877566"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 12:34:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ6gnU1aLnWI5J+5D8HjJJoSE9UxMgll7rwceYitL6rQhqVNqZZwWtDxFgQG1JTD5kMz/CSBflwWn6LzPz5OIGnf/T5ncC/UzBYMwrSxRiMpRIxd32sV/kg931i+tGUFV3OsXt3DfN0uBdhEiBBOIK9lRhUB/vGLYfTkG2Jk8ssyhXcthuy5kWQv8K9xBHPpns/6CcLNvXRFSunLhrnYugctQfKVTFr0pQoedj1y85ZlR2VDRQJMcdD4MCnrLTjkit12WtpRGlQWdlTNSSGHaw8zCuvh0rFbmWyaMD+5hsWs9ITIdcIigRcjBIOh3vg7E8bT72lKG9OV6P/R5YwvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Le/aSxFyM9e5c2D6/Y8VDx2FsQ3OgBcTf3Ql1lhZ8s=;
 b=dvfe6ZcHEipHsYWtrMoXfPx/OvZMUw1Am+MZ4HAUetkqZLzrYsSleBfbYEJq3VSDu6mSW8DptRCNHbUCvO2J2le70Ic9FRP+07ofBhb+5W3qYqF6HSLXP6O4ubA1qpaViQcoTYWg1qlDDcVtcQOODCqTxtmWdNiOuMRCUmOlJhfwupEGnhyMmS1MDDfQCmIyunurH1AwNXk/5896tEKOoiq/gabYOjY5QCd3DQE0A0LFl69KUHn0Cmojx33qfEuzHETqHe4YiDGxrfaNmgY6Xo8durvRGayA5MOq6waBFzVqc6Wk1BYomeXOBfnLOcsYdTsfj4/HhVMdSHIS/u9l0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Le/aSxFyM9e5c2D6/Y8VDx2FsQ3OgBcTf3Ql1lhZ8s=;
 b=PjFdinxxT+6VNgWJx5E1uCIbFTVocSLxVWPc9+UZhtKeiukQZujUzalxUFN5utIfVZAvR1BQMNdApUr4VwXPcOS+SC+gTMoTjrNx1nIkQmMlVe2Ey/B+Udt1hWmmO1LzqrVUNYA/QIDww+7FgEpWgtx1Qqbh6t2AjfUaCGv7MRw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6916.namprd04.prod.outlook.com (2603:10b6:a03:229::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Mon, 8 Feb
 2021 04:34:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Mon, 8 Feb 2021
 04:34:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Or Gerlitz <gerlitz.or@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/4] mm/highmem: Lift memcpy_[to|from]_page to core
Thread-Topic: [PATCH 1/4] mm/highmem: Lift memcpy_[to|from]_page to core
Thread-Index: AQHW/DCr64Y1yB8xakqJU9Z0zyt3KQ==
Date:   Mon, 8 Feb 2021 04:34:20 +0000
Message-ID: <BYAPR04MB496553A948A21877C7135A05868F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210205232304.1670522-1-ira.weiny@intel.com>
 <20210205232304.1670522-2-ira.weiny@intel.com>
 <BYAPR04MB49655E5BDB24A108FEFFE9C486B09@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210208031324.GE5033@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d1ea372-733c-402b-e73b-08d8cbeacd95
x-ms-traffictypediagnostic: BY5PR04MB6916:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BY5PR04MB6916EF7DFF6AC0934C60EBF5868F9@BY5PR04MB6916.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pb8mwMFZZTY2Jf3gIIoc8aOWAY++uSPQ10dR3cWHDfLczciRgsfr9uqoXHCEWVMPcj4pf35QWhslJt0PNcWW/+VUva4ELVx9KF+LNyq9ifNU+gU2yoMJ3goT4CgqFZ6SYFi40jg7zwXaB0a//icTO87hqTAR9RTckU3ntMs3GUlcBHRsFuG6nWqK/UYjAXaPq4h8GaMW4SeqWXheiOXnE/KI9wUXfjiTn860lKhVTgJGIJr+iPqarK3YasXJBegrxC/RH1xXYtTm6UJ9c1D5zhlI743muoKp4bDglNwnLSJrjRFdpF9BOPh0ABqtajRKIBq4c1Su3fvC3GdTYWvp6BQI4MygWZildC8fqhw10ekTfhwvtvbgAxfBSs4q6tyBIPH4+Me3XC1zeJwwFZBYM41qBAdo3w8sKibeOpoME6hv2/0nO9Ufza1j0wOQFTBEZ/5OmgrLgY+DN2heQ4OweduQD+x9k/V9PA2twog7K+8hF8le3uaTKlVNSnQ+ZEYvJ/BQg3SCkkU9WQe/AMqi1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(7416002)(186003)(316002)(52536014)(54906003)(5660300002)(6506007)(6916009)(86362001)(53546011)(33656002)(71200400001)(26005)(66946007)(76116006)(4744005)(9686003)(55016002)(66476007)(2906002)(66446008)(83380400001)(64756008)(66556008)(4326008)(8676002)(8936002)(478600001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZuYSnaX5Rtjki3boYIxU+Uy8XFk0KAvx5isO1/kTU0dek7LAPz6qSAe3oXsY?=
 =?us-ascii?Q?p1IcV0JmvLAyj0XV9DUR+WKUlXpt3X9yMeLzbqaCh4bZ4hXELcToYRoJegSt?=
 =?us-ascii?Q?6NDcvBS/vdZEvm9zhaMZFHo4pTeNF/DFDB2HKXhACy1DYZo4iik7tTP6a4o4?=
 =?us-ascii?Q?AWBmigC4WfFYakCsxPhXyBsCD58D0pK7vB5y5mfgsk96B/vaJfouxkgx+l5P?=
 =?us-ascii?Q?nG4/trytW5ouarvyX8aeP1ll9C7lHAM/iCAC4C+98CfoBpwulCTMfy/iiJPf?=
 =?us-ascii?Q?X1rYoAWUyfSZfNdzIEgJNn3CjlPXhfa6/T0XajTpngddH+QNPuyUdwLzfjKD?=
 =?us-ascii?Q?0jGOQpOB1TeN4+eYrExdu6WXh5hUwbqOmF3YVhfrflZ9wL5l7ztQZdQEpOzC?=
 =?us-ascii?Q?BH6Gb2IX+HUIV5bCSsVa/nf5C3QOaG5x7Ugdj8UME5Soo89KVdE7spcgD1Z4?=
 =?us-ascii?Q?t8UUDjte6VKdgZDJQPraHUHLsVTixTLtaLTduXgf6s4FWgcs+ax7KNU9Z6YM?=
 =?us-ascii?Q?7KOsPq2vebhh9YGUvLI/9NF8S1E80R5w5OyeoUCzZ4gXFy3QOqMbwjwC3TUo?=
 =?us-ascii?Q?2AKoii+a54TKVcSFAfz1Ps5MO08yF1KF9JgXHCQXFrQgXEpv3IO8qiVp0stt?=
 =?us-ascii?Q?6MH/OzT3PrcEtBMhY0IXGqL1XFbViK8PvozFlXCk8Obl18Oc1ivuqRykPUaz?=
 =?us-ascii?Q?0iv+ZCyUZsTAAPgNq0p9dlrfmzqTf825CRlKnDUp2Voq3zhDc6y/siHWeiPc?=
 =?us-ascii?Q?CwPTps4gJcb1b8DueO318BFLB6RuDUov+eILXC0edVybZE3bRWjlLrzaz5VS?=
 =?us-ascii?Q?1Ay6qo7d3n7rrHyu5XXee/yP9oAjIYhP7vQIqLeE8ORCJKy46D5ENzfLNYIe?=
 =?us-ascii?Q?kl8iaT7Me5j0QzsRhfNXb9Jn8BCWQo6oLngC2t/mhCzOcErJ3NHPVq3PXixr?=
 =?us-ascii?Q?AsJDw4rSnQ1Y9Ghif8ikjOSyAcuRNK0801Gcv1fG7jKSjnARolvxUByEfRFW?=
 =?us-ascii?Q?XBbDZFjKHnAhHf1nSFxrdNZBAiIJfGd+DCaNAv0HdFS29nhZRUqRpaaTWjiU?=
 =?us-ascii?Q?/mRrHAuD/7ggciI5hBpMOjhYi+MFOUCVtQoF+5EZrqbjUwsvPJh8/Up/LzjR?=
 =?us-ascii?Q?dkRpL2Ge1VeUA0SuwOrWU3WTn/SwH0W/90NByb9Bep1tZMoPWLJDm2IwQRAT?=
 =?us-ascii?Q?vsCQ9rchtTzjGSGsjgae7WNFMil8kiCBmRx+BVRsGD5OIU+T41PHmOcA8X1v?=
 =?us-ascii?Q?xK6erpr3txM+WXwVxYJ7TJNwxNkPES07RvJtUtaSf34Fh0FKCrAQmPxzBRX7?=
 =?us-ascii?Q?SgX8kKEEb9GD0IQlrZjip//z?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1ea372-733c-402b-e73b-08d8cbeacd95
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 04:34:20.3764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uiHK96O1ANBqv//Le26cATTUXyu3xpp/K8uWtBicc0T/5JQkseaw3UwO1J1iEAdTfA5XADtOWPEcBadcY6rYCQJcbJQ7UwYgm+H2IRwBIGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6916
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/7/21 19:13, Ira Weiny wrote:=0A=
>>> +static inline void memcpy_from_page(char *to, struct page *page, size_=
t offset, size_t len)=0A=
>> How about following ?=0A=
>> static inline void memcpy_from_page(char *to, struct page *page, size_t=
=0A=
>> offset,=0A=
>>                                     size_t len)  =0A=
> It is an easy change and It is up to Andrew.  But I thought we were makin=
g the=0A=
> line length limit longer now.=0A=
>=0A=
> Ira=0A=
>=0A=
True, not sure what is the right thing going forward especially when new=0A=
changes=0A=
are mixed with the old ones, I'll leave it to the maintainer to decide.=0A=
