Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8773187B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 11:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhBKKDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 05:03:44 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11491 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhBKJ7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613037562; x=1644573562;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7e6wLdJ9l7mwodWobHjKlaMpHwfB4OpGJ8LveFo8Lis=;
  b=j2Vg5tOrP2llYLYbPN2BXr9kqS5MjYgF4dQjW+g99bL50xa4HauH3kgy
   R0wwNDpJc27pOC4PglzxUM+ylwm/bD0pBVqUNcRaJQt6ivFrdt+cOqh3S
   6d8m9wNZGlO/dB4DO66gldRPeKpcS6/4zJPjbVTqrU76XoNugHqOFddAi
   n3PsXIiDicGRI0YAMrhuvpZIKXMt3dD+HmxMOiwMCOUPXxqFrw++kl+pj
   eb5jfEkxZ9OqfOXuVzBZAZmCOl3uOMzuUZ+hqEgRwDRjMgxGYztct3IAS
   cDg2DcXQ3fEDWRq8ZWckICVx0V2S6JEqnfxGwa25GMzdIbWMbgnZJmWCb
   A==;
IronPort-SDR: NkuDoAQF3yHhosLHAq3lEZ7M1XcyYXKzZ12LuLMUs1TFYWZOkqvK47+lCs7zt0/sjewSgo+gMw
 K+KSXeZxIJ5RdanVgKFykf2bfo+mcmuBcPN8rOhv0IYcTpaQUoZY8sKMWannzzq9puQF412m3N
 fqKOuSoBlJgiNyWWCb5xRjP1LN7oQWiQXb3I7Neht9IRZ6OrOal63HpkttcBpgoRSOqfmWrFpt
 CIWuvkT7RCkGPoIxCDzf3JY4spjoyA2BH/r8oZXOBwqYtfU9jb53MsF+xjcbjs0kVnauavuscz
 Yno=
X-IronPort-AV: E=Sophos;i="5.81,170,1610380800"; 
   d="scan'208";a="160912987"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2021 17:58:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM3YwoVxDSXwzA2oeeEcOGgqR4ldTOIphQhobuPNN/Xix8ac3vX/ZMkfkrkLMEmm7/8XRB/JbXNQ3GOq/hzpkjj0ixRwUYBRri4mgo0lKo/wxteoc0mCGQT2M9ZU3OBcowsNxse4SllMDIu+UJpnhXJXBfwRjEFASJDEgUZHaLbddQWpj2Yb9CW8zF5KLeN/YtvMTpJ3kSeWl/JQgn/wrwYbdy9sBiqxhZ+DBZ+0TidNHjRSo76WgHNa8aq+Tm+KnLHZOVp1sTgnA2xlO6EQtQdGNQOEhRzzK4Dr+padyG6NTBcy6vSilO+1FwVwh9/+Wjp3nK+HWkQun9Z0jckdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e6wLdJ9l7mwodWobHjKlaMpHwfB4OpGJ8LveFo8Lis=;
 b=m17NYzmm+1ZJkqZOSeO6MSYaIrY7ogZT8KkF+ALxOLXJbpAn07lbh62a7h2yaYL4QYvEnsy1YRscBKoKo6fhDyijVEU3EEP3LZ/WWlznCArCeVl3l5D3+yE2LqmBn1OD6HA7LwFN8JAjdeSal2AE9LUqeoMhsuoHXW7+WIXU06JWVdv3NdWPJG2wMa/UBf69MBGoI4hFJaQfkPooRGCM9taUzPAbPrPtS5SqheBzus9AeHl3sANyF5AJD+j0dRcLW/QaNhLlSkGo4tlQYWYvj5jsKNpQ6ooafiarfkgSvOfDykMK47oVgRAvlK0rzd5hwNfh2MEwtx53FcSqMjEnQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e6wLdJ9l7mwodWobHjKlaMpHwfB4OpGJ8LveFo8Lis=;
 b=QXUD43tqX48BZUJLpUsts674ts2ARcqTbEgPWZePveOgKxLq0lvFnL5xLVpZCp7ooRJsqf0ceDEC2dmmJxT+QL3MHWD8m5r3laFdRvVbKQzfqSfMQYQFkkJbY0LefbEPTpXpJiLzJYLSyZ6sbsyC3qLt1CIKp/WDVzYVJycgAcs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4400.namprd04.prod.outlook.com
 (2603:10b6:805:39::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Thu, 11 Feb
 2021 09:58:09 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3846.029; Thu, 11 Feb 2021
 09:58:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 00/42] btrfs: zoned block device support
Thread-Topic: [PATCH v15 00/42] btrfs: zoned block device support
Thread-Index: AQHW+uBDi/qAxtbkv0uUNvQXEiNsGQ==
Date:   Thu, 11 Feb 2021 09:58:09 +0000
Message-ID: <SN4PR0401MB35987EE941FA59E2ECB8D7269B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
 <20210210195829.GW1993@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02cfc2c9-5303-4c03-bed8-08d8ce73899a
x-ms-traffictypediagnostic: SN6PR04MB4400:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4400B93D92669AA1C6B6B3719B8C9@SN6PR04MB4400.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nNHEQJ1inDoj6h3MZBJq1aWSyRABgUOmPt/UZNAA6WEiBHkocz18CNTxBmcQ3idfTI0pJvWWG+ZSb20IN+rtoMlMEaWeKZJ6DOmVpzVyLFQNmh6oMNTmxIfLuk0r5bPrBCNHO7irWtxKK8MT14cfI36AVdYInzI5oG4jjQVs7Au6owOLEK8W1qRolWCxX2o2llBhRWsk27mU5Haenx/PPtrPkGnePbGK5uXKEnU/v7JXL94c2LY5wYrhsec1CBSEi5IT+62MC9yxxpWz12QNCgF01oDVKuN13S4iIhrTUiqA7G8hcykLM0ovkV/XtGX5MWDe4eKgVswJka9jYPlCDLqLTXa53tAt+cAf5yLNBArd/p0t8Xtxtv6hBORj9Izd5Qp7Ul4z8dbq+lqspn03xuY5eAm9ZuEFjMzFHogl8ZhecSX7p+EuHepg+M9hwQZALlfB5xk7ZVqeve3ux0JsxhyQrrivQ3qd/wooifBfMhURH5fcaRbBHjJ53t/FqsWdVduKtxKzv/5T+WzAx9Ijcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(4744005)(54906003)(110136005)(7696005)(478600001)(316002)(2906002)(83380400001)(33656002)(6506007)(4326008)(86362001)(6636002)(9686003)(53546011)(55016002)(64756008)(66946007)(26005)(52536014)(5660300002)(66476007)(71200400001)(66446008)(91956017)(66556008)(8676002)(76116006)(186003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5iqZq0vxK1J36TnMZvXSLX7bA7iB6cqEUjuHhaL2cM4NbJwHoy5Y4cVZa9ug?=
 =?us-ascii?Q?O5HWfS8vinPt9Yf0cR/zbmREaDaclWJKRb2l1J7+g+jJImVn6O/G+oeRBvgG?=
 =?us-ascii?Q?M9RjqINzu5IX7Oj13XhIjVHwgRBqBOpTacZZjpE2saV4fvh/lEZsWNZFZGsn?=
 =?us-ascii?Q?dud+HFRK+/vb4NuhDJu5D5tp4L6i/UMUdJVuPX369jdB4hIhLO4Erd0lNp25?=
 =?us-ascii?Q?WvNv/DxF0DL5A4EdLIb7zECNN31xVpKOh2w4vTkvFQgCFwYJob9Bc9X3VVk6?=
 =?us-ascii?Q?/5Axwo4mH50Fx8Nfl7+bkcShr48JwV4Qr+p/Xzp8O3lBmNJstlsgrAkWjHMC?=
 =?us-ascii?Q?lp/69h3HIDZE1vMgkYwFAUfsxOwIh9jCr7qArCi8Iv1M8k8egd/bwYJFb9yl?=
 =?us-ascii?Q?5qxxioAwuQuePlFiXzPhkaHHcslXIeKVUpZjO3aKrJsNlMK8HbtfCjQLJ+S2?=
 =?us-ascii?Q?PuMLCzgQ+WbnkJ+AwDKhg4Bz3Y25+Rhz/0kBKvxCRmNa0g+zihK1o9JtqV+v?=
 =?us-ascii?Q?9xhZs2H0a53XoZ7GTw+RtoQTgutOKuqRm22IOGP54ySUcMy+xLF8Uk2JplVz?=
 =?us-ascii?Q?RN+Za7N3tWQ+S9cxuSO9Rcw7Nj2BYYxT7EKQomXgZK48QL2Y2YuXaL/ZagdJ?=
 =?us-ascii?Q?3F0WuAplo57IsojShKtMt3Co8Y0kZoUsrdiXfYoSie8HmgVW85pryoP+W2KK?=
 =?us-ascii?Q?yD66nSOTNgdjqSVPCGB77dn0QPnwRuY1obupTrv3D3ocNMkj/RtJYC0ylrS4?=
 =?us-ascii?Q?otyJH7KigvWygNEE5wPoaSH//XDRMNxVEpRLIMU+2677M1fRULbn0mF7eT4e?=
 =?us-ascii?Q?Y2NMG9W52aei5pjc9BR3WJDHHFW2Rn06JGogYsogPv71SY3AFtKJNHflSfCx?=
 =?us-ascii?Q?Av+SsW+o6QM3OWzB7YnILOVmLgQ4IPyml8OEM/+ogeaUE7E9N6Py5fl4p+FC?=
 =?us-ascii?Q?19ETepIVq7bOFS8/uq8DlsAkxQBtru7qwNPbhVxclZovS8RtWTpjjKWpUrI2?=
 =?us-ascii?Q?dX+USt8XkGqQ2S0GX7jK17tEQewXuZvrCf92Rnrby41HvCMN/qvLqDxmWIpB?=
 =?us-ascii?Q?MMVfPcwOtfIMjt2dx0qRLiz/aKcpJQvJzxBqcbYmzkDDmsPsiHjRxZQZdG4z?=
 =?us-ascii?Q?JMi2c2XRXO6XC/RrV8iQ0YAPEbzNYtxHQoDBWusf2Yh19P2aCQ0HBcxt/u6m?=
 =?us-ascii?Q?nr2CqJ8t3WY2kfStWbOhvPUZSIdswN/qsfmcARn5gFBzx9U8580z5Vl8LuqM?=
 =?us-ascii?Q?b/pjvMXdrE2zNGKs2FVgR+kMTPEdGSTpqBmdMuHsDk8lP3WGdPmVcmtCqOmb?=
 =?us-ascii?Q?ZCsjJyW/PVBdDvVIvMscIvxm7uwO+Nzaj+5Ts7HXtL1dMg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cfc2c9-5303-4c03-bed8-08d8ce73899a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 09:58:09.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYyaYolOkhccfm6YA9QXyRFrudXs7wGkjP3IEKYU6UsPYDRu9r5yUwLsfwGC6+QatfY1uuRBNpE8B0WIUKGTI9lBN0rvzHuiNmlJe6BoHT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4400
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/02/2021 21:02, David Sterba wrote:=0A=
>> This series implements superblock log writing. It uses two zones as a=0A=
>> circular buffer to write updated superblocks. Once the first zone is fil=
led=0A=
>> up, start writing into the second zone. The first zone will be reset onc=
e=0A=
>> both zones are filled. We can determine the postion of the latest=0A=
>> superblock by reading the write pointer information from a device.=0A=
> =0A=
> About that, in this patchset it's still leaving superblock at the fixed=
=0A=
> zone number while we want it at a fixed location, spanning 2 zones=0A=
> regardless of their size.=0A=
> =0A=
=0A=
We'll always need 2 zones or otherwise we won't be powercut safe.=0A=
