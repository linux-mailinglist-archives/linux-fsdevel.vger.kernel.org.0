Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B56B30C6BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 17:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhBBQ5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 11:57:16 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25023 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbhBBQvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612284696; x=1643820696;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=H/pH8Rdi23qKd5AijlNIXuFDj+x76jJyJuBI4b0dg60=;
  b=S1TlmEVdON3wZtTLWVTXsLo/4eMHBmm7IrY+1EaxxPC3yhQ3UcFc9BdU
   qMkh03V3SBNeb6ydGjoN2qRuiphvL5YGTNoMnpOQbSqA7g+ko2lvcLJxg
   GHCODLZL+umI2LRRaNQ3MqZgWFNFqhsJ4GH2Mm/7/PbkljEPVrz/DVwKf
   nL3H/wjGRbN0I6Xzj1k6r/ANnDSrEjCRab6604SCcLQfRt9/fO/Buxy3d
   bQhAhVcV5NDUD7j00xOSuOj/iCtG2NOC+/ThrviDS7PQvFFg0aFL5mEoY
   +sMWWR+rkqYqcQYZp6cEg4XTl/n8DnXuHMdlQWfzNVaf95TRjzkAFJV/B
   w==;
IronPort-SDR: 6dJ+ny0yppOjnasQbqgq7iWI+FaqmtsaqXt39c3XZsH8TyD9YjwYi9trVXqCPQyLsVKSZSDp3V
 aDLkRw9+HDJ1A5yuDmKOIzKWbAzn6RflRzQNHtfGwty4JsDWxphcheB2RQdyEqY/oxgtT24QOE
 uYlonLekLmcFsq5KgYEv1Wrnu96WJFruomnZodRG4cefM5ehqH0QqcPvLQ9KAo/ZisK+u8KSgN
 AO9pH6XkhcqBscbb1s7+Nk+IPUOsLqs53GRv90Nsiw1o0o/Te7bJhGb4vBYrYUTYFewEvf9bGy
 4cc=
X-IronPort-AV: E=Sophos;i="5.79,395,1602518400"; 
   d="scan'208";a="163386517"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2021 00:50:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X01xJIgGm2PLWo0sim1Md9K+e4419JF9NLlyb7Hy2jili85mvLwQ3e+lNM7qN8WbYADwxp/MEhIoJOJl853Bc7xVR5aPxj9iYHneVVoxgpiwW+ARwKbljHtmNvigIzi4pUnL8CErzmWww3tYaZ22vAJfRkX5ta4wfjLzc5MPiBQnv/JerhFEyG3gPkMEW4F+XmapsGyTJnntz7fEzg9Z3Jd5Yjbg3cE7sOBKkfyqmCv5G09AfaUevhP85D3ctMLQOJshMp2lXkQsVMCneWhfLCaKNopsrQhPHFNMCkiZHoMD/qXvOP7o2pHdNj5XhAimNOqTRUD2sm0WLFYsa1XcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBoREoLOXcfWu4cJ6KZ+xz00M3xE/38LrxcOdTmiqrc=;
 b=ZVvhJlHHCGluOaurHZBdDHPKt/2w8V/8wIa0Rc6z6y/Z+NY50Wzd81VGuYjyIY3iI5GB2pM0AMUjhrwclounam5Hf4WYCj3zgOVJinM3442eHHnBL/v3KJK0I8B9nb1VWNkWhJOOvoN2BMMnRM/5EbqjLm/D/sz+sKxfyaDQVuOv+twHG1mzXtwNBwrOPBpxh4tIj5gIHjhH5d34lwsPHv52ZPriwqE2RfJqM29LacrYkj49MxhfYzMpPjK8LI2WsL5BhjEk+ZPBi8nI0mfK+X9j03QziV3VrMNSEOilNZLlwvUe6Ga+A3U09nOMi+nL0fpC20GwCjIgsVXJ5TDt+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBoREoLOXcfWu4cJ6KZ+xz00M3xE/38LrxcOdTmiqrc=;
 b=gWLeZDJ7FrpeIfIRwkFPEtWENz3IrieTDvh6STOfAho2ODVzED7tcE/PQunzbgTs31FJEJDxSCLtn3QeooMk4TxPZUtWqanXidcTsFttj4GTRfBOkcex49QZblS3cXmPg7CpG0cx34uUczbsenHHRi8MbeE/1Px+PhaPtbr8J1c=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4862.namprd04.prod.outlook.com
 (2603:10b6:805:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 16:50:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 16:50:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v14 32/42] btrfs: avoid async metadata checksum on ZONED
 mode
Thread-Topic: [PATCH v14 32/42] btrfs: avoid async metadata checksum on ZONED
 mode
Thread-Index: AQHW86bDGUbdBl8uuUe+/6H+L3tqug==
Date:   Tue, 2 Feb 2021 16:50:26 +0000
Message-ID: <SN4PR0401MB3598A4EF13B1D61B3720E5889BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <13728adcc4f433c928b00be73ea5466f62ccb4b9.1611627788.git.naohiro.aota@wdc.com>
 <20210202145418.GX1993@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:51f:6b4a:2171:57e6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2b75d2a-ce14-4cd9-479f-08d8c79aa435
x-ms-traffictypediagnostic: SN6PR04MB4862:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4862C85376C9AA85772A3A559BB59@SN6PR04MB4862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xcfuMWKrIZxqU8yFGhChXk8YTk3wiRN0odIZIOGcPcuKoc+zyuzEYZbF0eHTgIpP8yj1a/MA3lQEBuea3v9WIKh58GiCfhsJne2Li7ADeA2e2x9sx7jyUWF+hOpW4NRbY3PtdQWG1LM2NxXeRu0OwgjVfIVDbFrmDgyqRXQAG/ON6de2lRb3hwOQXrXmdvQuLJskaXkHb4KJEIU3wAWTkWlb9zXxWRKtUZW6UbmZzDEaEDcmXIMFy6CsxusivUqw9A3r4IPuQ1T5KapseO62u2B1zlElj1+wC1j6YoO6KhNzEqOPgjv5RTEv0TnLL/9J3E6VICcPQzw0HJ+TQevU7E5o4ymstNjUy9LSh+Lvx/OOUovBUoGFdVlpCbBkzmMpG4FPOyq7clq5TVMfBLMIyKZizLqamxtKNF2KjjzYa02G2w1wfRXmvjVadwRD5U7c3B0lQMce9wfQNrbux2+JyNBpkQSw09bYI4vzlQdCCJXaSU+H0jVrJTi0wC/iAWbTJPdA3RAolbNz6BFn+0Lyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(6636002)(53546011)(76116006)(55016002)(66476007)(6506007)(186003)(91956017)(9686003)(86362001)(7696005)(2906002)(52536014)(66946007)(8936002)(66446008)(4326008)(110136005)(5660300002)(316002)(33656002)(8676002)(66556008)(478600001)(64756008)(4744005)(71200400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+m1yCE/gtGo5TgOIDeoELMYLRk3riKTas4bIHMFjTGp0bsG/tsy6px+dXkpi?=
 =?us-ascii?Q?DVa6E/PcbPp4hITU2/wz0gikzlZvEePKlQJU9rv8aYLTXAXpzl70kk4lYKSv?=
 =?us-ascii?Q?uP/IrDu/WklIAKBTV002rM1zlKzkVmpc0o9cIuvLD+lrP/HWPBUSOsbpmH5c?=
 =?us-ascii?Q?9gY7hUbh8zO9HszvqeX/MC1g7ds5rtO9sg8IWvcaowdKUSyMFLnojVcjmlRL?=
 =?us-ascii?Q?MxRqp8DkzctENC+tSf7r6PzZ0hgPXzlhqLsLiiOJkcx9gQO3IGzHydLOEtNt?=
 =?us-ascii?Q?yhy2xo4edOeEFlL0Jd8ViHBShbzxkB2a6/YxBJ+UqMm3gYNZoBmPhaRraGp6?=
 =?us-ascii?Q?hch411LbFINgCacVCxY8Oyv/ZtPgCyHlCNblAUC53Cy5yjljEykPbQcOHvEO?=
 =?us-ascii?Q?wKf+TyhWzN/hyENVF8PakGjPQy9ThxgQIKG1th2qz+f4/DKOYw1zZURU/MJB?=
 =?us-ascii?Q?ATlxm9Mvf/d+/GMUB1t0sq6vMCtkmeToTGbwaJFBHkV6voe1fdsnHAIoJhfW?=
 =?us-ascii?Q?/LHaYGiKXWT800xDpWww2T7gSGxcaNnLDXv3Tj5qMzvFZDJBWd6gc2kHNSq7?=
 =?us-ascii?Q?edcnGggyF7nfSLozMcraHbJyBV+loF6okEL6qdeN7Abv3LheuZmmo+0SMC7C?=
 =?us-ascii?Q?E17H5qfjBAyZsgUYjmw6kxs2d1YEhm1BLn/TEohVXWpNHqn+2NvCYZ3iHVzS?=
 =?us-ascii?Q?Ltw6m0Ysze8/tSBOd6VtWTE+OwWmno8DAPc0GGY/krjtV0/0oGXipY6t8l+v?=
 =?us-ascii?Q?kxE5OeLv/jMP7XTS+2ZAHbw7LwtrQCNJYnphKbA2ZFiYmJf+mHB0jtVnjF9g?=
 =?us-ascii?Q?aKZ5JEzxnuar+CIy1kpgA7godTSZROhZv6V9jjUp2s8EJewHXyn4V+e7U6qx?=
 =?us-ascii?Q?jQpD1n7tUkJvspVgBmmulFcp1OBmFVby4vA6XNM34a3PAlNynCpECIQrN9N1?=
 =?us-ascii?Q?JFbEEFBF+UoLFp25alkTVWMRBPh7lmeGy8o16ZJmlnCUETi2NFxYn1CJGyZM?=
 =?us-ascii?Q?vI8T8pQ34lkOq2xFQuq1S/PKkCyq9u8sY/MRShjSRJwoennBUjdR3CZKBs5h?=
 =?us-ascii?Q?qGds753eebkr7UnsFGpLq18X4me1rufiIdjOhHygB4/MUqDSqOFW347/z5qp?=
 =?us-ascii?Q?fsxGznbHU7QhpORJe+aOTZ0GnhR8ibyc/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b75d2a-ce14-4cd9-479f-08d8c79aa435
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 16:50:26.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxDXjrql2kOzHln+9GYyclFz6FVjL3NT4iNed/dx7kJkB3E7eLY66syyMdOVF3I0LoRXGphAXhw9HAk7B5Tu8VfEQz39WTm2CqjeaHrhRGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4862
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/02/2021 15:58, David Sterba wrote:=0A=
>> static int check_async_write(struct btrfs_fs_info *fs_info,=0A=
>>  			     struct btrfs_inode *bi)=0A=
>>  {=0A=
>> +	if (btrfs_is_zoned(fs_info))=0A=
>> +		return 0;=0A=
> This check need to be after the other ones as zoned is a static per-fs=0A=
> status, while other others depend on either current state or system=0A=
> state (crypto implementation).=0A=
> =0A=
>>  	if (atomic_read(&bi->sync_writers))=0A=
>>  		return 0;=0A=
>>  	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))=0A=
=0A=
Can you explain the reasoning behind that rule? For a non-zoned FS this won=
't=0A=
make a huge difference to check fs_info->zoned and for a  zoned FS we're =
=0A=
bailing out fast as we can't support async checksums.=0A=
