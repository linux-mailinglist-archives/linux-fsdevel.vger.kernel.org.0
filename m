Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A124E315F95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhBJGic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:38:32 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12654 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhBJGi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612939108; x=1644475108;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OkmEisbdXrff6LSaFbFuPlU3nDfUCVU1o7DR85Kujvo=;
  b=XjEgoPvOB7iuHi1InuVX5q2iob8haED8qiP7CMsua++FOWNwzLSTKx9o
   HsfAQW5xIM1gMpgwMSa3JaSApW/oCcoSpSypEiJdXuu+wK7/443NaCBW1
   BIJOtDidh4ubocgbekE2AmMTSA2W34Xo4ZHJVoD3OpEX9V5Wqu6sIFfxw
   CLMUfrO2mYxXPLuRcIVgwNlqHhjfUcPD9Sh9CeH9be+t1FwuaQSGbf7fQ
   vCYYVqc3BDUFA6XL7B/Pv2ggl0UAFuGLE0kJwZFu/umKIuOYJO7IRhSPX
   /xxx6fklfhlbzZe5FPBiKLkgcV3Z6Jnb34rAcehKuBdm+Gsr745FFc0a2
   w==;
IronPort-SDR: nwATtwIe7p79KPgU8fV1bE7wlK4WN/cGhUVorFTUDftG+FZaZta7Il0hVgW1RvUDldlwuA9Jub
 SkRzxnEEsLsApiqpqg+l6N2id+yVMUdh2Ot99kuy6IvMuG40CLKcpg48bVfCN7hfCZ4ja31Z94
 pmoai30lMlCw5GC3QhVjCiGHGmT7LV0IDewuE3bgGnoPfWL7unQA7bHbqnjkUvrqG2+4A2bXvh
 uTcW3q8tOwR3foB2C0K2NMyKEbIFhViTBq8QMLttZjpkWos8W+5h5h3Wsp4/hvmFNm6b78wKrI
 ps0=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; 
   d="scan'208";a="270083426"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 14:37:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojjuxu6Hcz8JJ7xm/04DJcamX0DEJIhyymes/bI0AbEG/obXr5FZaf4kezacwPMIQEcDVh4hqhVnt8sM0mq7XDpLmss0uC5QMmcOfqXefZhAOF8qcig+CBocGwxuZrv7g+o8CAVs0kc4XQqvcaPH2cqQwAOnmQAX6PeMIPU2EiXxAF6cgsS/rIGjxGCaXNxScqLyEXHu+OwsITSMZVImZ3Hg4ykGE33NBODlykys9wEUARK3ntjORtAfdAG+KHIVwZ4vdaVzTSTPMyGnoAYneimskKHwoJ8QUnCMm3AGa5zXOu1Nm8YK3mOH49kE0rT9YKO5rjKy1kf9Dsh+qGDUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkmEisbdXrff6LSaFbFuPlU3nDfUCVU1o7DR85Kujvo=;
 b=k+7iiAYAKqU6owNZCq5gbL3KA278iWEitr2Oh0/bNU2yEDzdqvdUM7Wh14JOCWhhsa/RHmLookTqGfC06ahbll9rQLQYt/Abyuhm+rICzwB6WGJh30C+cxTFKPn/645mBrStfqeLNIjjytMcdCoKucspGeJHBsWo8OzXDkgKNinXOVRiwavUinF04yJYR98TSo0BT4H9YOE7igeOOR+I+rr6Dy33DWikpVKhCTJ4O6rXQaaKGcqpQ6dxOE7Q7x4hZtcMotxJaQF1xkagJHxck9nw+eAdG1i0EobD9Y5uHL7MQGCAWtifWBglmfiYVflkAz44b0dzBkgcrh5BbO9suw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkmEisbdXrff6LSaFbFuPlU3nDfUCVU1o7DR85Kujvo=;
 b=AM7J8hToeB5lKUVMGGUXFcjQ6vdkI8io/EkO68iL69/RIJFGbR2y3z8Q2DkmfZ5oATzj87EmO1j7sZDLwpVdach4GyfT3aCeNZ90P1UujqQqwWqTqss5HbPdrvJegcZHaUOtC0TgjLyjXKI7EYLkGmZ4K74mQBqAJFu1O0XiKOs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4326.namprd04.prod.outlook.com (2603:10b6:a02:f7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.28; Wed, 10 Feb
 2021 06:37:18 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Wed, 10 Feb 2021
 06:37:18 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
CC:     "hch@infradead.org" <hch@infradead.org>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2 2/8] mm/highmem: Convert memcpy_[to|from]_page() to
 kmap_local_page()
Thread-Topic: [PATCH V2 2/8] mm/highmem: Convert memcpy_[to|from]_page() to
 kmap_local_page()
Thread-Index: AQHW/3WAiJ+evlPvakGj3UlNB/i0wg==
Date:   Wed, 10 Feb 2021 06:37:18 +0000
Message-ID: <BYAPR04MB4965526BBC924C25175BED9E868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-3-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36dec9f0-7856-4a4d-6818-08d8cd8e5040
x-ms-traffictypediagnostic: BYAPR04MB4326:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB43269BE054827CEDD59599BF868D9@BYAPR04MB4326.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HYdrNH3ClLsEq+a7KcXKK6zb71wiwJJeuYHGpQXzXITxQ0yBhE7swvzNeLEJ7xu+ezihWXAwXhOHMduZ82Fga+srhXT5QU5MfA3btO5OKQJ/05qb5THRzCaRUUGnEW4+IMzFIvbMKHhj0LEwpaBAkJOGgs7Ht9rXwVTi4n4KsXGN5YEadNAtZjNQW7pLoFh7FeYMJGfPy6MMBavaGXWNj1zi7QC5RfISdEho1FxLP6iX/X6Y+4j28c0qpnqAAwxOdG1i97gFKKjUWSDSAlwC641Pci7ZcseLd2+9c7zT3KggFt7LRnYljBwoaXxzjOZ+1LxqqJstesPLq/p2Jy5UlCjPMVZCb0a8XSUAJlum/9k0Jkcsini2yYOabmY0aZfhC+BgYnWFxdJIX2SAB/CkO3nZi0xtifI28SdJPiDkeD3iLqIg1R9c/tdNrA8BDRrFYL0ZpiKIvLUoDcePjKGanGcRO23/gr6JUB3frFoAj/ZISFEKKwwfrqghjqXJcElnYDqyMwklsGCldVx7SIDkfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(86362001)(6506007)(558084003)(186003)(2906002)(4326008)(26005)(52536014)(8676002)(66556008)(55016002)(110136005)(54906003)(316002)(76116006)(9686003)(71200400001)(53546011)(64756008)(8936002)(7696005)(5660300002)(66446008)(478600001)(66476007)(66946007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QFUNKqiP7wkVWfh62G/25IvTMGJh4DubNKvGUcZ/HiHHQMOhVp6gLEBDkHVs?=
 =?us-ascii?Q?P0BAKzf052kR4BzqPrha/S/k3jODWLK4RiQRbSqAvKkRyBHYo8Jv/ztUoYtf?=
 =?us-ascii?Q?UErM6ctOXKFC8orZgnUIPPSWn9Xi17rF9JO5KjJyrlUEzTLPU/uy+Sd107Uq?=
 =?us-ascii?Q?I5MwpPJA3FWrlsnDzyJ0HItQDsA6I5/hanIiIcQxGhonsfUvB+GrMvt/A81i?=
 =?us-ascii?Q?MZURTmVSYtvwyqCu3K92fLG5kHJVjdwxarHjSz/1lIb5DEPKUAI5jLeeqTxB?=
 =?us-ascii?Q?0nQB9E4af+xpjH9jPDKv5+lY3M/MTK3iAqPE9nUTopDD6wfCGOtU5ichs3D4?=
 =?us-ascii?Q?TEcXfa1/B1/nux+Zcs7Gmj4Nr8BZ4iRSwYkzq+hqLFeRooih1wmUd1+KHZ6o?=
 =?us-ascii?Q?1nVS950PzG9Cr2V+f2tMvUaKxtjgZH7I7KTTzuGrfrSNgK030wKr/IXqC+Pu?=
 =?us-ascii?Q?g4wGnCoi1XnveF5/EoLE6IPzvAOvYqLhF0UQWvrIH/VrNkYh718ln55+tsRi?=
 =?us-ascii?Q?k9X8DQpAohc6kLjmJ2iSKLhfj4vmVnVV5euxdKvkUWEl9beCi3XuY5gM+OrQ?=
 =?us-ascii?Q?yRorB3xb81p18XkgXjqeJAAKne7J1To4vhnQK4/83LaGVeFBxWZlLEMqbZEq?=
 =?us-ascii?Q?cuOIFSxhnUpTtl9NvWGy4yFnHbes9gSqfA3TQo1zdj//uoJtmWLWhmjZF1EF?=
 =?us-ascii?Q?6PgR7FiBv0nMnmXT0o7dLdBZnQtzuZaT5NctugCu8BIfMBJKJgdfgdtXYu4X?=
 =?us-ascii?Q?4CkSJIZMtQvdHNwNtv+0LYiMyMlvsuQuvo5yyxpyaihtKBRmQaa/AShd0Nlj?=
 =?us-ascii?Q?cQxW/2jNYofIdAmbom5bzDWiCktwEGRNOTn1+9uubPIbEWczEBdTcWGI3asH?=
 =?us-ascii?Q?SQajVIivoz9Uv20qiQhIlkA1OQHO3dE80MF3sfXnz6PdQkH4Uqi41xDDRR1f?=
 =?us-ascii?Q?GiuX7TFNJDJKztJLpsnYxLpAkB9/6fYjjf8wDtGxW8KmTW+GyJK0D0gpFzEG?=
 =?us-ascii?Q?AWLrFZLv6+RoV4Tvb7dmi50qNn0yppZY5XaXPpSKnWRHxLEVZkuetJcb0rMp?=
 =?us-ascii?Q?kNnF11JMsTxgPFi7sxZb6/FG7bsqb68zKPUSG4xUO49v23Mdx0Nm9d4uNlLk?=
 =?us-ascii?Q?2wNooZJtoKllVTGH2a0NDuiovCWIu6PJJahv+mEPU1h6q3F0+eEcfsDglVTg?=
 =?us-ascii?Q?xy789q84NY2Lxx9ZrUEzhiNdGj4An3MkGIvb4hE36VtLrG7YGKzpuLru1DGH?=
 =?us-ascii?Q?nPbxOEg8thzyq24XXvOTF2+21+nF9j31ipbgPgtZ6c95ghuZwxvN3aSMxDEY?=
 =?us-ascii?Q?lvNHUs2EtGOY0Z7zqN6BzU9o?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dec9f0-7856-4a4d-6818-08d8cd8e5040
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 06:37:18.7713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: or/CrK9DEyfjN7tXJFFhsDCGJrgjKVzSzo+OJAgGR8MQIOk/mBJjzX/YhG1SDOypE3jYOoeh8qEVnNaA6ICxn3TBilGR3lyuXX1yvqr61y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4326
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/21 22:25, ira.weiny@intel.com wrote:=0A=
> From: Ira Weiny <ira.weiny@intel.com>=0A=
>=0A=
> kmap_local_page() is more efficient and is well suited for these calls.=
=0A=
> Convert the kmap() to kmap_local_page()=0A=
>=0A=
> Cc: Andrew Morton <akpm@linux-foundation.org>=0A=
> Cc: Christoph Hellwig <hch@infradead.org>=0A=
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
=0A=
=0A=
