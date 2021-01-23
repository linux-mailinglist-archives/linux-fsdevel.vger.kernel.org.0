Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28AA301286
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 04:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbhAWDJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 22:09:59 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1616 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbhAWDJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 22:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611372147; x=1642908147;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3XclkR8L9i0FGb3L0ElSvIwlZkppnoPbiWyWoN09pm4=;
  b=RYGDA/wNTIWxcSMh8XjjBF3ORc2gYDA7xhojcYeQsj7tmZ53i/+AncRE
   S3tyHcleZahpOTuPvHHDqaoRFhk/MmxJbmCpUaioiHJEMhiSYnoAa9/lY
   Y3NVaIvvWWRf5EBdAhswRttSf/Qs2gubEheESF6DUI11N5Hp2VAdRLMNq
   BS6cQtsHjBf2LTJ3WRdMox1KZ/xCDAMu9C5gDEPf+oVj2lI9tj5JW25Uw
   I983NABgw5d99IjWA6WffyHBikJh1Oh2bGwDc1yEWZZobbCPKbP2wOMnu
   hDGIuIhJX7J2O011PqUL/c/xy1oGnjxmE2v/FqZwr1qaRhrYXSzAKhwug
   w==;
IronPort-SDR: sydCJ1OwDfDZJhfvSI0HpS8AnP6IOZCQYgUkix5QEYna2wVPP4jfY275WloNYCk9YFM9qnTaFE
 DW48Lc4sMUs87wKXo3PFu2vqoCZ0DKBRBn4IX39b08LGBpxQjIaLV4AGP8dR1R70UzkmBzyDx2
 449VZft+1bjEY9ZK3UeNbhP6kmoEnjtyGDMLSzh9uk1hRLwcOeyEUUYmYQzU6DHA7SINb1YnDz
 smCo0t2V8ct9zCqvoTx/XtY+cmcaFlfpFS9QZJMx5GK6zXG9WJrkf36+PoDsz3sooxic6PeFiq
 5K4=
X-IronPort-AV: E=Sophos;i="5.79,368,1602518400"; 
   d="scan'208";a="262128620"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2021 11:20:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITYljzQ1Ce/rOcxqSFYro7Jd0uqC3MGayy60VU2xHyC+4X0LZ480GBuz5VCtbMIQeg6vkIfbZ4xDcveK/EePESrGzB24imSezdSez40EVSSXX4imRu90VObirQIRJ3RA32zwXZS3rB5AYdNIxYxNyiRdbAWU32icUmF3yXfTvHGhASgyMqnfbRJm39tt3J8AIEhGGJfP8ik04ZpIn5+cfVq7kykB+qR3IcFFucPEFZpBKl8NF1agKuqwM21wjCZsoQnONOaWfMw/FfsNwSy7BW5JEuMLnYW9jMwxOqoK4WaTgEJIpgwNIbg8Jk+zJxeH2lW1caFidA2UYeYkzLbNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XclkR8L9i0FGb3L0ElSvIwlZkppnoPbiWyWoN09pm4=;
 b=cW+MhB6FfKPTMlLo5dFNYnbHFFM3ipAQvqQPJoo0vhppFPKHXqkTeemDzcHL7DNSQh+lRh/qxF7k1mFJCXQnzgxiTglBkUPRRrvqfZyH9f+9h2ezKo/+hZEazItHqmWsfpztg+1tOldEjeInif+SAX75wr7fLxnk0X/n+qp1OqsjDLMmYc+PeppdCPvyT7LU3XhOKYvKwOLKnyECPjqkceUtJWJ01elAfo1Iruv2r03tbxrHA+0oVn+h1x2mkgQGNgJe1RbTgiMBLvfb/uaZVxHKtnkgh+XEd3PDTjxi8A29l135RQwhs+jqMdu5io6lPi+4cf8CKUHTFb+zEXrLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XclkR8L9i0FGb3L0ElSvIwlZkppnoPbiWyWoN09pm4=;
 b=s21ASWVPy1i6uxArV/ZtJ2mxMNO/WdwHX2O5NJqlvcTSXqYVerzLXcgCmgBgoenuKUlLGWgqKqAphFaKV67G1cv1mFRlOd5s3gdqTOBkXplTizh/QOblRMCcz09N/DNrfOv1MCTcXu1rW/6NBvCzYYfbSn6HaqnBsaTOJFWmCL0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7124.namprd04.prod.outlook.com (2603:10b6:a03:22f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Sat, 23 Jan
 2021 03:08:46 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.015; Sat, 23 Jan 2021
 03:08:46 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v13 01/42] block: add bio_add_zone_append_page
Thread-Topic: [PATCH v13 01/42] block: add bio_add_zone_append_page
Thread-Index: AQHW8IdLf0pDgmmWhUSc59BsHZKVgQ==
Date:   Sat, 23 Jan 2021 03:08:46 +0000
Message-ID: <BYAPR04MB4965C32AEF520983E56EC52686BF9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <94eb00fce052ef7c64a45b067a86904d174e92fb.1611295439.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:89ac:da1d:fcc3:58a9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9171d7d3-2a5b-4bda-1767-08d8bf4c32e2
x-ms-traffictypediagnostic: BY5PR04MB7124:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB7124067840746844A29E477A86BF9@BY5PR04MB7124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bKAVvpVfzfy3Ip3Nvjd70KaID18V2bf0D/8e0DNeVYiJfnce3twqNLi9Pdr4DJyDOUs04R37wQUjAN4/cXwNZbjPuuVphNA+qTWoFLwqMLG9FHNGphINGjHdTI6yEl862M0ti8AY24DwbWXfGwiDAmo+IZFjejzK621gV6UZKpg+bJsB3mnp3YKpspHh9HxPowsjdSp/jCahLK7rWTanB3Ebcf4ZvkGEEY8zhFGAUGas3Bjr5mAlbUd3yFmZb7hDualI/5GmZtCnC83sUWvdjKHC0Nr3n+QptJHqW9ofJOs/Mrm0CIwlIexT890uZRfXpcnp+gA7q/+yuO3IzYgX+++1AHtDAjXKDZkt9htkHf/WWMtLzgebGPB2nLebB9EIo7HQKjcIzzCTQTWOxUY0hA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(5660300002)(55016002)(110136005)(71200400001)(186003)(4326008)(8936002)(9686003)(54906003)(7696005)(316002)(478600001)(4744005)(76116006)(86362001)(66946007)(8676002)(2906002)(64756008)(6506007)(66446008)(52536014)(33656002)(66476007)(53546011)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YVj912Li8ob8a+UqW6cuN/8dTrVyy39H0HrjzTzOkH8EihgENW+fQopZsWWJ?=
 =?us-ascii?Q?dPcRv5YvdT13Vu2VYzEmL4W4i3N+ExvT7G0qbIOlvemY7DnSJdoatdkMsM5l?=
 =?us-ascii?Q?jp5ihBpBrgqyG+C4BLFDR2suiqjnSVwWafjOzSYFZ0+/HFpdNhoxoAQFe47z?=
 =?us-ascii?Q?Zuxgrfg6dhTOC+DJny3Qz0LDRpXZibKT5hmvsXZXtgZS3yQ2pA+JajNr/L01?=
 =?us-ascii?Q?WGe962tY5FPR/Jwuc/suON8hDSfe6gZBC42W0oEw51JGnB4QO8wEsXptmN0N?=
 =?us-ascii?Q?eNH8zfSvdw2V4zvmrfa/57VVsBmSQ9hm7SpNhki/uw/Bp5zHY57CkEtBzn9r?=
 =?us-ascii?Q?cyq/LEx6uK9KwhcaRVDn55nJ7a+duct3Jq3OQsbRcVXOYY6AhI5XJC5sRspe?=
 =?us-ascii?Q?VZx14NtpGm+9qDgt0w2WK0JWHVtjN2QUi12iFnPkVZQcjaWWMVoct7FzKrFj?=
 =?us-ascii?Q?ASF2kOCh9oq9YKpyQAHEocWWH9hydIsRbVuJLQofvn4y4yvNipYxgMyZ1Pnd?=
 =?us-ascii?Q?5KtCYfZuwjvlM28S3IlBCSqpr+hjfQfGTHrY3dYPa+dbwQmQsCif2cxfjr/o?=
 =?us-ascii?Q?Hi4eE8HjyW1B1J6hklU0oKy3tW03X1S1f768Fxnqqnh90YZJykB9zT4nswyp?=
 =?us-ascii?Q?o4cSCwG6ZW8olf9qXAVyH+Oskp/yIB9yrVYIT9WSS/Zot/FiWMBHXHf/gzmB?=
 =?us-ascii?Q?96NNHwJwP/ZIYDxSXhoYL9WcfqoFnsBvMDjc+H2YmBdHeRETgGWCsOBIVUxe?=
 =?us-ascii?Q?tYnUaF/tHTgOAOl9sGj3bTreb8khGDSsKG9+oWR6tfGCmWsbgnO3w2EbEOv4?=
 =?us-ascii?Q?jjwx6N/a2prO0fi8TMPCHzRNDoW3tHV0KLPQo+X/XxCJlBezUbXw39yiuSQR?=
 =?us-ascii?Q?PWpJERMrTYysX1nEkgix01bjixeZkqpG+b+k1+qNuZ/dU2thtVovgj+uLxsU?=
 =?us-ascii?Q?A6Cieq5UHc61IxFXSEPDqko3v398lty68je7l3tlAX21PNefNsCjJ9ONOE0G?=
 =?us-ascii?Q?D7kksnspUaNw4iwEzhFmcV/hrW3RqHv/QJhPLff5vEnFSYKlP2W2MYhJp9HL?=
 =?us-ascii?Q?HYIxxvOe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9171d7d3-2a5b-4bda-1767-08d8bf4c32e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2021 03:08:46.4303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVK2a5dg9huRGSucwnTDzIAzvzVFHCfJkOkEFXyMG7+pLfXeuzpjDwljD8Pgh0/fT73ebyU7Xc2/NcrNovspZnupPUPVrsfMJN9NAbwJSxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7124
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/21/21 10:24 PM, Naohiro Aota wrote:=0A=
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>=0A=
> Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which=
=0A=
> is intended to be used by file systems that directly add pages to a bio=
=0A=
> instead of using bio_iov_iter_get_pages().=0A=
>=0A=
> Cc: Jens Axboe <axboe@kernel.dk>=0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
