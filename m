Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DBD30F6E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 16:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbhBDPxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 10:53:39 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49772 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbhBDPwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612454000; x=1643990000;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UHBsay9c/WFb/lBENd6m1wwk/931AOxKNlJB/aFUR5M=;
  b=J+jcvi4urXfhftrJ4FSG0Ukk3MTo6OgyfnAzIMZTEyQJ1iwlekHMCyE+
   kJ1I4qUjOqZykxXGZR0lDC0TiAYLwCIg+xPmqgBekvXs87j3OSLTHvMjj
   wjoUA1VXnLi8v9x9HTgfiHXF0XESgPG+yvD04iWG4YSjltu8BdK5TVzL6
   T2Lt5POJTiLF8P2YgSREwQBn80M4MKA55I8mqTYUIEChTj8YvlLiGzstB
   1/cZP1+zfx0anx4dMkLysQDNymHPEFE6jmNXTcf+ohexZWZUD/ge3gMyM
   Nas1xtxypSSK9zBbB68rBMYVsc6KpaX2n0KgG9gGS4uRQ6ICXAh/7AweB
   w==;
IronPort-SDR: 8h996w2cfu2K/SbW50mJSE5lb0kOFtHWNoE382ATzhwsO7Ml641sR736RXsQIGn0GqjfyrCCKr
 ta4zrrGRPGl0+W6gPlJmhgVC3w1mgN9Ok+iretukYpi78ZcpZIgw0jO2ZTQTgg6KvhmyVK2WbA
 CkoNvlZP+4HumfkbqigFOyi0n4seTFt0teWHc0cON70yKhOqjxNz5qA3vrg4fNFqlRBrt9Gfr3
 ZGC12VTz6WFuPcpmtHMJONWbxjhWEGZv1zvYa+8DnhSax1v13bC2iXKQ6XUu/Gt+8X1YvhTqsZ
 oPU=
X-IronPort-AV: E=Sophos;i="5.79,401,1602518400"; 
   d="scan'208";a="263227936"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 23:51:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTrcmu95HF2hDIhyvbFWqryj2/xjLEQTDbjdc8W4ZxcVfkC4EJSSkTje6LpqXXZOnltk0hCRURzpEJt6Mx4GLkAgq85CDYzFuEbc+3BLAmuIM/dfksh/T9q6a0zRGu+85JM8PAxnlhRxmPSYLVDHBN0VdDUZjzFEBIKy/uZZTDflcm263bJu3TlSsVcsa7h1bi+fULu8TV6FhUk4hF1cu3eqwlQ/yyYdD+LTRl2D4bi+8vkGMIgOZShhLvabgjshuenUvbyO7wGYEn9+EkvI1UHQPLU6u8NTc8V5VbE7cZqqV/18q9dwEZ/H3jJAFnqgZ4DU1XOemgr56JxkTS9ZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8x5fKMABE60BhCHmbQzlL8utKZlF2NpwZ2t/YK9Lzs=;
 b=Arf0v/YJktB82w8u1mYF3riKJqqG/fsaLPHt38fILX0SfoBFUBsDTRWA7+UrKr4f/ZOIeVXzmlX7AHMcqmsLfs22G56DxB4Kq4q2D0SzfQUDSUsMpOGt1g9d65T/DN1TZn386DLbj/ceLNEfPhezpe+duoem701L5KLFkr4AEYd2OYqvRGoxoBwFElMfDcQaulcUXl2HsUmUk4vY6FI9N2fvkvnaCmR8cQNnsg5FWHi39uLhvLAKLUq8NyRwzBG9YwfMva4xgMPcfXqOGQQ+6I+M3HIi30KjnhJ+5cKXm0jn8wKtbXEhcRyA7CTI5EpPWskb3viv24ypGG1Y/PAe3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8x5fKMABE60BhCHmbQzlL8utKZlF2NpwZ2t/YK9Lzs=;
 b=CWICMQFJupfYwcVgCP26+OgHX4YqocBJRSuu5Y81urOQ/YxKlCil/fZ7T8KWsR36CTT50oNnZDddi5GplZSJumWuSK2D83TsJmLv374R1QOPl7uCYUbyDoinDIhXYGyExd4uAJ7neDsjTFp1HM71xfZJujUjOxyScmqivn/l+IY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4861.namprd04.prod.outlook.com
 (2603:10b6:805:94::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 4 Feb
 2021 15:51:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 15:51:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "fdmanana@gmail.com" <fdmanana@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v15 41/42] btrfs: zoned: reorder log node allocation on
 zoned filesystem
Thread-Topic: [PATCH v15 41/42] btrfs: zoned: reorder log node allocation on
 zoned filesystem
Thread-Index: AQHW+t/cYJgQtdxbUky0cyLYhI9sbw==
Date:   Thu, 4 Feb 2021 15:51:14 +0000
Message-ID: <SN4PR0401MB3598DEAD6778B31DA9FE0BCE9BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <492da9326ecb5f888e76117983603bb502b7b589.1612434091.git.naohiro.aota@wdc.com>
 <CAL3q7H7mzAngA8SF13+FOgVserhF3iyA2a8tggYuO+qi+woLOw@mail.gmail.com>
 <SN4PR0401MB3598B6C1AAF3CEA92E167AE89BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210204154841.GG1993@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:ece8:c906:a370:a858]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e34d279a-5793-4fc9-51be-08d8c924b3ce
x-ms-traffictypediagnostic: SN6PR04MB4861:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4861779AD3CD7529F01770AF9BB39@SN6PR04MB4861.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FqQLNawC0Smhn1mQI+lNlaNC0umrrxJGBuo+VOu+5a0E0bO1ucyItEM6LYtDV+3X04oVEkJQNMluKwJU/sQQTtZOQFAFI3x168M0pzS+hw6yWjWPOsNL7MmGyLWuzVK/ED0+aJemauEUMrs94YVe3x5faxqMRN0genx44yeN3OIkZWtPhBIEPlp6O1842C8iEp01iE6elsReURwm132fP09V9W8DHjZB4QuR1voUAmU17l/YsANyfQ0nAQ1ihVFT5CTNISCa1nX62qf5cfEVB+WW8AqucF4G+2m0P3GrA6cpQpqkzOi9R9IMlyD1iaks1FpTmYM21FlS71Lb3qqXvRGirZ7V4m6+ROAIkJY5UPE7jU82DT8CjyytTFBHEVEitrjYc7D/x5OWcWsi49htT1+ET3w85YOBvqvww86NxiRFS+ELy9CHd/dRQ5ouv3bqHb1SYIqtCGEbOeoBgsUwYiVZFdR/APNVVw1brh3meESMW4ictd54HA0fXVMb1WsOKFQ0PiYawXZ0velPuEpt5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(52536014)(8676002)(6506007)(9686003)(478600001)(71200400001)(5660300002)(186003)(54906003)(316002)(8936002)(76116006)(66946007)(64756008)(33656002)(55016002)(66476007)(4326008)(53546011)(66556008)(7696005)(83380400001)(6916009)(2906002)(66446008)(86362001)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cfaneqGPKSQCEnkTJiDAa29j7Q4IGuRwlzwI7SbOU01t5s/R5/6F82QhgOJS?=
 =?us-ascii?Q?1tGps0iaPX1agPr+a8hL19R75BtJn8Zfu6tGHSmQpBx6MNrnfPvpEtJvG/zM?=
 =?us-ascii?Q?NGNsELQzONuDuppZjC1i6M0SxXkHIPklHPQKxHFO2CQw/bNa1YZo28EGDnHX?=
 =?us-ascii?Q?VJm96/tXl4wIF0WC+PwcscjidJEvsK7gP9b8adQ7/OGc0EUC+NvTjvkEVdJ0?=
 =?us-ascii?Q?LMBrtSZqG9IA1yQrVox0cbBfrSsq+rpIHJkBf/4rBR4uHAMweCrP5LkHOqAv?=
 =?us-ascii?Q?OT2syq7srpkwWKE8UbZ82wtmcQk+wD12OhWs1x3dWOzqWWTKTGL3rC2vTsDy?=
 =?us-ascii?Q?aBPAWZVCQa+IG1MuWqO+21YxhH8XxQz1kUuxKKPCMT2eHMuioz1chlA94uG7?=
 =?us-ascii?Q?GiZLjHPCUOozqam9+hhZMcoy6wbc+gK5HzNTHsYOfQqQDxgbkZS8K0PeQBev?=
 =?us-ascii?Q?V3bbLF0xXVgfyhUmvYB9OWJ7KhyHUaibH2P7Lhuy9p4Ihuc8eflX3V8P0AWj?=
 =?us-ascii?Q?C1maV05HSvTfNF0CSD5v0EF1QDfABRzcCPO8NshPFGVkTAoLY9q+LI7gbVbU?=
 =?us-ascii?Q?lcD42vrFC98SH+Tm4DsbzOQNWlDEAKhWmqTTKlB2OWkLF/MUPhaKdLjOvoSq?=
 =?us-ascii?Q?2tPFUoyofL114jVVV9bmB3FtO8qbUWRtOhVb9uud3x5PiDFiMHoOu+29raLM?=
 =?us-ascii?Q?GnA2zVmI8mnuqA4n7UA+DbtzWbgt1p+PUQfcS/N26Z7h3P0ESEwB4BpKqt6Q?=
 =?us-ascii?Q?UHOVeg9M2mEr0miIwJd2As8+G3DTV+1V6BtFAZGNfPEMgvL/y9dZf3L5rMn8?=
 =?us-ascii?Q?PChoauvUPJ2X+bIvTJZhe6496GFcsMd8XEy5RZop2U9GLF8Y6AFshXIsWnRu?=
 =?us-ascii?Q?UwrNI9EA4Tbk2RtSaV8wBo22/F2L2yOKIVA5SM+Z25Cb6HNxV99BuHULxCTQ?=
 =?us-ascii?Q?ncWWrHzKKH3A3xTPsbt/fKPgc5a5WEtO1o51m5eRmID49S9FRvFQJdNljGgX?=
 =?us-ascii?Q?6y8I+X1hPq6VRJGFTv3KtPweaeIyiYwtVJiGZA5gjW8+Mswbb2xlsYqWLnW8?=
 =?us-ascii?Q?1RVR+sVDRDqkDP4zfPMPm1Ox0k96gLDXvRZDuMh5tpIvh3mAIj/WcHZvf4kF?=
 =?us-ascii?Q?gAps0xtxq5tmrmSwNqN0Oftt6X5TntbK5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34d279a-5793-4fc9-51be-08d8c924b3ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 15:51:14.4234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRis8rgnBlHUnAdwVBC3bcPZ/a6bKkwMAl9RlOuO+Z0Z3KJ9l/Bev/KLsCzHLE9U3UTzNNwejCLsKP7qRFEqCmXfkf+Cjxi2BQ6SVeazh5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4861
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/02/2021 16:50, David Sterba wrote:=0A=
> On Thu, Feb 04, 2021 at 02:54:25PM +0000, Johannes Thumshirn wrote:=0A=
>> On 04/02/2021 12:57, Filipe Manana wrote:=0A=
>>> On Thu, Feb 4, 2021 at 10:23 AM Naohiro Aota <naohiro.aota@wdc.com> wro=
te:=0A=
>>>> --- a/fs/btrfs/tree-log.c=0A=
>>>> +++ b/fs/btrfs/tree-log.c=0A=
>>>> @@ -3159,6 +3159,19 @@ int btrfs_sync_log(struct btrfs_trans_handle *t=
rans,=0A=
>>>>         list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[ind=
ex2]);=0A=
>>>>         root_log_ctx.log_transid =3D log_root_tree->log_transid;=0A=
>>>>=0A=
>>>> +       if (btrfs_is_zoned(fs_info)) {=0A=
>>>> +               mutex_lock(&fs_info->tree_log_mutex);=0A=
>>>> +               if (!log_root_tree->node) {=0A=
>>>=0A=
>>> As commented in v14, the log root tree is not protected by=0A=
>>> fs_info->tree_log_mutex anymore.=0A=
>>> It is fs_info->tree_root->log_mutex as of 5.10.=0A=
>>>=0A=
>>> Everything else was addressed and looks good.=0A=
>>> Thanks.=0A=
>>=0A=
>> David, can you add this or should we send an incremental patch?=0A=
>> This survived fstests -g quick run with lockdep enabled.=0A=
>>=0A=
>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c=0A=
>> index 7ba044bfa9b1..36c4a60d20dc 100644=0A=
>> --- a/fs/btrfs/tree-log.c=0A=
>> +++ b/fs/btrfs/tree-log.c=0A=
>> @@ -3160,7 +3160,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *tran=
s,=0A=
>>         root_log_ctx.log_transid =3D log_root_tree->log_transid;=0A=
>>         if (btrfs_is_zoned(fs_info)) {=0A=
>> -               mutex_lock(&fs_info->tree_log_mutex);=0A=
>> +               mutex_lock(&fs_info->tree_root->log_mutex);=0A=
>>                 if (!log_root_tree->node) {=0A=
>>                         ret =3D btrfs_alloc_log_tree_node(trans, log_roo=
t_tree);=0A=
>>                         if (ret) {=0A=
>> @@ -3169,7 +3169,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *tran=
s,=0A=
>>                                 goto out;=0A=
>>                         }=0A=
>>                 }=0A=
>> -               mutex_unlock(&fs_info->tree_log_mutex);=0A=
>> +               mutex_unlock(&fs_info->tree_root->log_mutex);=0A=
> =0A=
> Folded to the patch, thanks.=0A=
> =0A=
=0A=
Thanks a lot=0A=
