Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040AE2B0217
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 10:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgKLJjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 04:39:51 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57557 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgKLJju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605173989; x=1636709989;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=czkyMT4of5cBA//uIHbrPrBkvuw8JvxCcfm/dzxoyuM=;
  b=cmEwILUPe0LB/XEh3y7vo8o+7nqOVe/Z/SuiZmzVMdybcpQcWHWzXQA8
   BAA6vHSEp2ha7WbJpTQXbHl4aB2m6E3P7H68JB/QxUS4TJGgAc2e9PDzQ
   IMQYmncHRWZJf7y5X0dDkhT/uoctfeHXrU64TMl80HGmYk4m3qH/VQDIX
   9mK0/x1r1VeU1AkrONcI2wfrULOg02mm/fwoTcktxxjRc+mJLFRit9LoO
   p+60HHISmIjOOwNGRatwgS3SRh27vzltDdL5XrdXzDcWoJvdsDCseGjy/
   nzYDOi1WgZ32Rl7wmaOjuXIMGdrijgpgBoeZ+KOzM20o6h04LPdpKZRtF
   A==;
IronPort-SDR: +mKD4OunL8ug3i/aefwV9hy906MnJyyR3+oVlQjfppynsYrSMEvWtPTIoQKX+bEfmjiVEIPuKJ
 DftX56+YlYs0jFU7NkonxTSkBh9BY6ukWWvh/fqMayEqdi4bFrenIO2AsJOWQ+XIJnQZC/Jdsb
 +mNXqAubRFgHYHbK2XbhHth3Y6iusv3Wt4n6UpLGMuRWh0GsctEt0hAb0yYlZPdolSEcaU6RDr
 yvT5zz7KxsC1gG9KsRVtNB+uhwiZM4rwzh7LDq0GLhAboJciJVyWGf8eksVMtUmm5Xv80K2ZTn
 l/0=
X-IronPort-AV: E=Sophos;i="5.77,471,1596470400"; 
   d="scan'208";a="152367281"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 17:39:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvhByYAKKt6aVoKtMtFfO4slfvMSOrFZpp+SRz1aZ/ZCfak5hrBO3lp06cT3NFQbcZY/N2eiBPQeZbJu/l6C64Q519iCBPawFaF9xUlfWGICAVw1mhHmmCYzWUCFnlVqAhI+zUfaU/LbTMXQ2WWMjNz2LOqUzEx6jdFV+gxec/DYtmmYfLnX+tJVY+gwO9g26J47STBG4Dc6abaxkLCltvf3v2BrYxo3iUPAAJRfOQVKFSQ0FcSlwTxeV9T0T4+SgfCSh3Ig8+3g7xG1eg0KYWXEgLuAFfmCkWrE4THXoSaApTaxNEnb1nudpTV45WAXaocB3MwFcmbeYPMs+JXV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JGyXBofJwHdvWPVaAAbXuSBn5MFsixvMpXp2P4oC70=;
 b=ToQ3LDrbk5LL7IMCGRg/kaH0sxTIaDzTUZVTjbZbhhqKTXMaXtb4m/n5hLls34OIgr2wssWgY0zV2byWe9cGzSB0oCKY619V/x3cr6e4ZGc3wZko7mf5LmAhq0xf/bzet+yXlhHqrglWzfez5DwesB3PtHMuNdv9m8u5MQlsKJ4hzgjbkoaEwfXLEyRUTBAadZyDON9v6YZwB7MdusuzpdlDv34jOAvW+M0UDlpftN31G4ctU5+FS8qFNxlbUc5xe3vbDkSa66AcJtfXOu7LipWrWqmz5uJ/tMZLP3yBzBRaR0UYgtsM2ZRq+PjngBufAS7lLaeEih0TvNniMAtDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JGyXBofJwHdvWPVaAAbXuSBn5MFsixvMpXp2P4oC70=;
 b=pF2bxBmdsG5/N8u26wM81vfI5Y8dCiYoQ6rf/Vnagjp2H0vNrfwa717q2dSiFi16mGB0VEzMW0+yHLL2E8s8taWCHYgJ4imEdAgmPZZLF+9iTr5uyE9uMX5UkDFElKEV1qE9GYZwLgAmnBPmpe78xQz1x3cSSxYIgDyLLgFX1Z8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3519.namprd04.prod.outlook.com
 (2603:10b6:803:46::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 09:39:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 09:39:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
Thread-Topic: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
Thread-Index: AQHWt1SikzZ873WBFUWuepbyYg7vfw==
Date:   Thu, 12 Nov 2020 09:39:45 +0000
Message-ID: <SN4PR0401MB3598AC45D1040EF7874B06D29BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
 <6df7390f-6656-4795-ac54-a99fdaf67ac6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:145b:5101:3d02:4ac1:70fb:2ebb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e6a23b2-8eed-4cab-f2bf-08d886eee3e1
x-ms-traffictypediagnostic: SN4PR0401MB3519:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3519DCD04212821BF47F68339BE70@SN4PR0401MB3519.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kmY+uHjLibIzlNzxwjIUAtjmO3PLv7dgYSMDvWrRa5grjhspCDFf9dOEO6wmoY/oK4jDCF+HPIgOimmG3ZF+TEtiBmFAgEpCDReazC7BLRjV0t83t/55Bd1+MO6PD8Ravn0NzDKup/Agw9xCUM8SZky9y5gJFkf4cPWbuxK39IEHlGFsvxvatc0/ePvSuFqMSsd0pQIRKsTROOkZyklHFMT8PyonE+VvRiiH1ya7T6uQZEGEHCzrdEFAQSBotgHPKysRn7jC1oAP6imKF6WHdKW9tcFZfUU9fzbAvO0zEkxH+v8e1wU+gOHBTXuBZuQE/JLyGQQuVOluFLPBcCXPuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(5660300002)(7696005)(76116006)(6506007)(478600001)(71200400001)(8936002)(2906002)(186003)(66556008)(66476007)(66946007)(66446008)(64756008)(83380400001)(91956017)(55016002)(52536014)(4326008)(8676002)(53546011)(33656002)(86362001)(9686003)(110136005)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: H0QzL4KqQflqCkP9LpNMg7LhDWs+FzCTrIykt1BfUbfBKi4h3aOBKoXFhINvQvB8mjjzpn7ymXUq9TAd3s27yKFKAUayx/WZMynnbdzqNfTmZClNQFqDsjIX/LrHrGXtEqLCJrQO+aEtZs45Fl+hcqW1YGFK98+k4o5y6N3AJNHe2Yr2gPlQaW7+l7RKb1MrN0GHZyOyZ0Rp1ld6qwYfnzFLp7pMHMbBlg9VatSvNkaLpQzrHvLpm2SpmdGXYbj8MLC0WwJQjnbW3h9yeYRPjLKG5hRvJEHFrAMR3YA2zNfmTBvy1oJybHUZ5eiRuevjcVzboVUpOagwUn3gafz7TB+b30zaFjqZZTaWSN3aPbIGFsyyeCsFMOnGlOgmtUbDi4adxcJymXarHY5WH2G26GKXfuuhuRPBZz8rJKSxU+mWTobARYvvTX/8ygSPFCLXydepJH5Xu6rzOCKIUXnBdWNlOpaEKNKCa/6+BB+tfb61xKTisgtvpRMUB/DqKfSLNH5ctWBFsPYI6Al1JiZZzt6dCA2T7eFbnSgEporbLJfxnxbXiWuNWGpVpGNNCea2JFO3ui1wg4sQTB8JYq3m5FECMSMlpqbvO6SpYyiqVL7jxAq5WVodKf5PcVYj1ziuWLAYm2fJOqivxUj/BVTUo9lCskZRNSiHHI+M3mKaVgU5RTAKJu7ysc9EKeNu6rEAzH4Gx2WwSQMltr4BPzbYsA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6a23b2-8eed-4cab-f2bf-08d886eee3e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 09:39:45.5645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ykl/bPa012zRyOS9aRH4LiXulN8aSwuClui6BjcaiM68/Yz2iqJiOJoAP3R0rcJ5BDSDShrDHL4R3Kh2ibmFmxa0cfEuyqNY4RHczPtswio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3519
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/2020 08:00, Anand Jain wrote:=0A=
> =0A=
> =0A=
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c=0A=
>> index 8840a4fa81eb..ed55014fd1bd 100644=0A=
>> --- a/fs/btrfs/super.c=0A=
>> +++ b/fs/btrfs/super.c=0A=
>> @@ -2462,6 +2462,11 @@ static void __init btrfs_print_mod_info(void)=0A=
>>   #endif=0A=
>>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY=0A=
>>   			", ref-verify=3Don"=0A=
>> +#endif=0A=
>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>> +			", zoned=3Dyes"=0A=
>> +#else=0A=
>> +			", zoned=3Dno"=0A=
>>   #endif=0A=
> =0A=
> IMO, we don't need this, as most of the generic kernel will be compiled=
=0A=
> with the CONFIG_BLK_DEV_ZONED defined.=0A=
> For review purpose we may want to know if the mounted device=0A=
> is a zoned device. So log of zone device and its type may be useful=0A=
> when we have verified the zoned devices in the open_ctree().=0A=
> =0A=
>> @@ -374,6 +375,7 @@ void btrfs_free_device(struct btrfs_device *device)=
=0A=
>>   	rcu_string_free(device->name);=0A=
>>   	extent_io_tree_release(&device->alloc_state);=0A=
>>   	bio_put(device->flush_bio);=0A=
> =0A=
>> +	btrfs_destroy_dev_zone_info(device);=0A=
> =0A=
> Free of btrfs_device::zone_info is already happening in the path..=0A=
> =0A=
>   btrfs_close_one_device()=0A=
>     btrfs_destroy_dev_zone_info()=0A=
> =0A=
>   We don't need this..=0A=
> =0A=
>   btrfs_free_device()=0A=
>    btrfs_destroy_dev_zone_info()=0A=
> =0A=
> =0A=
>> @@ -2543,6 +2551,14 @@ int btrfs_init_new_device(struct btrfs_fs_info *f=
s_info, const char *device_path=0A=
>>   	}=0A=
>>   	rcu_assign_pointer(device->name, name);=0A=
>>   =0A=
>> +	device->fs_info =3D fs_info;=0A=
>> +	device->bdev =3D bdev;=0A=
>> +=0A=
>> +	/* Get zone type information of zoned block devices */=0A=
>> +	ret =3D btrfs_get_dev_zone_info(device);=0A=
>> +	if (ret)=0A=
>> +		goto error_free_device;=0A=
>> +=0A=
>>   	trans =3D btrfs_start_transaction(root, 0);=0A=
>>   	if (IS_ERR(trans)) {=0A=
>>   		ret =3D PTR_ERR(trans);=0A=
> =0A=
> It should be something like goto error_free_zone from here.=0A=
> =0A=
> =0A=
>> @@ -2707,6 +2721,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs=
_info, const char *device_path=0A=
>>   		sb->s_flags |=3D SB_RDONLY;=0A=
>>   	if (trans)=0A=
>>   		btrfs_end_transaction(trans);=0A=
> =0A=
> =0A=
> error_free_zone:=0A=
>> +	btrfs_destroy_dev_zone_info(device);=0A=
>>   error_free_device:=0A=
>>   	btrfs_free_device(device);=0A=
>>   error:=0A=
> =0A=
>   As mentioned we don't need btrfs_destroy_dev_zone_info()=0A=
>   again in  btrfs_free_device(). Otherwise we end up calling=0A=
>   btrfs_destroy_dev_zone_info twice here.=0A=
=0A=
Which doesn't do any harm as:=0A=
void btrfs_destroy_dev_zone_info(struct btrfs_device *device)=0A=
{=0A=
        struct btrfs_zoned_device_info *zone_info =3D device->zone_info;=0A=
=0A=
        if (!zone_info)=0A=
                return;=0A=
=0A=
	/* ... */=0A=
        device->zone_info =3D NULL;=0A=
}=0A=
=0A=
Not sure what would be the preferred style here=0A=
