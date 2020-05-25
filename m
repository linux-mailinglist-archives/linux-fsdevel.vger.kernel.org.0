Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762C61E0D8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 13:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390213AbgEYLoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 07:44:10 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34149 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390142AbgEYLoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 07:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590407050; x=1621943050;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/e84EJMbz4KJ1ZL7qi3X8SZdRDnDFzDnIJx/+uLF4L0=;
  b=U5j62iD/3VQslNcPRVL2xvsJ2JGZrhPNfLY2o6UhVRouzUgBVczXdGWP
   p8klYX9XjJg5YhR68SlkpxA91tOlKbMdZhzxwjJ8Kxwjn4Y7oes5dtBOi
   uuR9TnBVX3ag7VaP+nNozUWFaZbPpKmvF/qGRBEa9h8CwSrA+QqqHOGIC
   mNTG34ol+sBZzg8Dr/jRjAk5HWhp/aeWjQg+aaWUbUwLr9UENQXmUVSS2
   2aOXD3adZ6l12w9P3NCfJooFxAM9xc5ory9DK7aOzBFMVwBTZ79D3Buu1
   7NnB5wvFg1LR2+l/VXczeMSjsB6JG7vjTBUFF7cnQ8v4D/vLmnYShbFNn
   A==;
IronPort-SDR: 1AO5VPdVQDus9kDfFbutk0xltB57mMpVwTcsUalfpbjlcKqoDW/7le2vOP62qK/KmMmXPAiri0
 cTdBefUgKJheanLX4Kso6Y7tZYkDACSU5Ib8r0KgHcjg1yQvNVU1+NiSIU6Vef5FgyQLhY6YG9
 DelgO7KVtSsfvjouvnszxmMlrplW5djtJwxrsCRa7+xws3nUzz3nQJJXeAUC6x7h5JFjsIzzpi
 PFJtJgEo9QdHJDwI5LwQGvHZHbNML+NPGWi+CdLPn7410uOAXbIPNiFIOJrXQjz5t9iqncIVVb
 OdA=
X-IronPort-AV: E=Sophos;i="5.73,433,1583164800"; 
   d="scan'208";a="142787135"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2020 19:44:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExHvmkz0yZb7ugb82Wu1+86xwbZQwYY+kzjTNveRJlLqrNPoVc3eF1aKptyO4jOIQqrrZnqmfzIw7lqzPa5S1i1x4nERkrQOT+La0tSV42RGEZ+PutJz/dGphnJK/zZxi1r5hDK6uzz8ksME5g0lLpnA5tWqSNLSKcetmZOf/5nN8yr8YLvowX983hhr7LSakiwgCAxf90UZt5fDeHOWoFP9pWQR9XfZ0G40BRJpoXFmYLEi1norwZfjOmoNWad5xsLlkHZszvbBeXEr77HM7FGywE2hswYbINySLZn94ZRVetuOkNOTXU8jYvi8iHFf6o9GwXyi5pmc5x5O+gmeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3H0fP2oJSsuuqHHs0uw+eGDboBdnVlnFD1BiP2/nDQ=;
 b=jwZWQqwi364FEYVoxtf4SrHmTh2n93X0+GD+x4eYTMPRtOd41q7EWVZY/wp53bUESdetINylSumBwIJSvz9iWwKWcwtbQQ+lBMUVaYdN3LaWXWAKzCqz5D4mDQbsazB1ATfDS1kgaL49BaPeA2RtUSnU0q56vSZ+JoFnIqSl2DYcGKJwJDdJxnvs28xhh1EW+kdYKChkV+94BBr2KrddXt/6BmcNl+BOOaXgPtlgdC+svtE0VAoUPA5gw7TXHkEDBYKoGNYUx5IhBdH0iUJoGLIQoGEvDNm3KAHKVMn7iD6w0AFHoLe50gbDZ9MooRioE2ZWNjwZxRrAAXzrYIw+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3H0fP2oJSsuuqHHs0uw+eGDboBdnVlnFD1BiP2/nDQ=;
 b=bjj4ploeFEZBI0H+T9b8lOJHLwM8c9C2GMO6yneYYF1rTUGliV0buh/2HrNWHAa50A4bdcOBOnngeN1I/PeqWTelU03cFlu3nUoKFm5gwiz2q7xGwi0onT7nw9WsWLnsONVb1xI3MjCFYD2+emm3GpwO/lY3VwC38/REtLAbj4I=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3662.namprd04.prod.outlook.com
 (2603:10b6:803:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 11:44:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 11:44:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 3/3] btrfs: document btrfs authentication
Thread-Topic: [PATCH v3 3/3] btrfs: document btrfs authentication
Thread-Index: AQHWKdGHpFk4qUNYxkaDbw38lHwpUg==
Date:   Mon, 25 May 2020 11:44:06 +0000
Message-ID: <SN4PR0401MB35989EECCB34AFBFED58E20D9BB30@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200514092415.5389-4-jth@kernel.org> <20200524195513.GN18421@twin.jikos.cz>
 <SN4PR0401MB35983AAF3D05F84AACCF8CF59BB30@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200525112622.GP18421@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a32661a-2934-4b8b-f228-08d800a0ee3d
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-microsoft-antispam-prvs: <SN4PR0401MB3662AC22492E2873F4951A949BB30@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x36MpWFaVCCzqFzWYCN2EYB+P2AC5XSd/sL+GsccOZ4OvZHT+9v7ovFBPi7XmB9UEq5RJ4U+BBgkpGqGzMV1aWoNiP8UuAyo0oz+6NeipAtWhn8svviPHbSCPqdgmqSVVrxL2gUnQd9Do8znZ0TGrrPDsV6znIU2YILJz2FAE0YOBhSJUnOn5MJ36O/5RwNX6C7dYBS0WoCgEwLKXkSQwJ3eruiH8zUMfiLpvuCmuU/JcCFroHkA+BffPP4ja8sGCbk35GYKP4axcsso1wSQh/lA7t66mWiK8XJgOEydxOvL9bT0RXZAkRLR/vJA0m+BtHbiVSfPg8HUcmxqUIbjnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(26005)(4744005)(5660300002)(186003)(7696005)(8936002)(478600001)(6916009)(53546011)(6506007)(52536014)(64756008)(2906002)(66556008)(55016002)(4326008)(66446008)(86362001)(54906003)(316002)(8676002)(91956017)(33656002)(71200400001)(66476007)(66946007)(9686003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 76aXLG4UZ3iWnINNYKTET5BrolXoQvKKtt+mLZiGstsLX8u8cvUu1+pdt1+2YHMW+TXQ3uXzUS7NS9mqb+xbidYctu+8rvp68hmr5BkwmSE/z5hAPiFotEjjjomA07raLJTPBmfDfrUOpjrhnufPLX9NCrch1XkHJzlEMpvgF7r1eHZdnuTCmw4XSI1o7gOEFdBxTdvff/hKEh3S6nS2MRUTtpeM9ybLwP5rn2TtAiXl0MVVQ1Pyqhn5Sqv5Ud4Lg+ftqcFw1ds4EsQZ+ze5xwgSG9cw/CAe+CQOE5LBZ0Sz5JsOqo70GTZ2O7uiifRclKNLmQpaiO+3R/iaD8IbF4Uk66I0uNafXjQShdubjOGhaHot/BjXOML9NIX+H3qelwkjhPkwknHDbfAbwF5UeeWJ37LhGiyHyndV9OjTXSJLD9IWRdkzHi1TpFZcR8Ro06TqICTZEI6tzTx2N9BFg68qTp4OsYnoZwYKpEDYgQZ16/7xa7XB/opZQKk214el
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a32661a-2934-4b8b-f228-08d800a0ee3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 11:44:06.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/sHU8jooHnbfEpWup3OZGKGfiksahrOdFEge0T6cHgVfefKWlZ6qSkrsCFEI0p5TZTzLVEQ82xFnovUpQ+ZgRakxroV+6WBK1lKuVpxBLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/05/2020 13:27, David Sterba wrote:=0A=
>>> Suggested fix is to have a data block "header", with similar contents a=
s=0A=
>>> the metadata blocks, eg.=0A=
>>>=0A=
>>> struct btrfs_hash_header {=0A=
>>> 	u8 fsid[BTRFS_FSID_SIZE];=0A=
>>> 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];=0A=
>>> 	__le64 generation;=0A=
>>> };=0A=
>>>=0A=
>>> Perhaps also with some extra item for future extensions, set to zeros=
=0A=
>>> for now.=0A=
>>=0A=
>> This addition would be possible, yes. But if we'd add this header to eve=
ry=0A=
>> checksum in the checksum tree it would be an incompatible on-disk format=
=0A=
>> change.=0A=
> =0A=
> No. It's only in-memory and is built from known pieces of information=0A=
> exactly to avoid storing it on disk.=0A=
> =0A=
=0A=
Ah OK, now I get what you meant. This should then be only for the authentic=
ated =0A=
FS I guess.=0A=
=0A=
