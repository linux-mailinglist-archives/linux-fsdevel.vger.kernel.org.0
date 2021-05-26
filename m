Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9258D391719
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 14:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhEZMNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 08:13:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19779 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbhEZMNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 08:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622031107; x=1653567107;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=A/fLkGFNJLYGOMgSuSdnQ7y6GKUg2aOv7LqkVVTuRCY=;
  b=DQdWxz+P7PPHVDzRgjcQHyzcpgHM3kFMwBm2YT2VQcNXtm8K/wLLWosf
   +jGAqP8QRT8/0MuvJvW8sgg2cgd4nbXDrYOVZFNs/AgbXKC0GyU96ECT3
   1WMZa4PjJBWVU6vLcpWEFrFIE2U69RRSzBtD4n5PuPcmnhenMQizChFcL
   IAXi9T8wJko9o3PYWjEjHXfKe5F0XaD/XL4SuQeCG8o82XmzLSJl3mcv/
   r5zgO0+0y7vhiac/RUWMu6aP/1E1ei77P5KU4pamUPpK/kUrEzKrjQWX0
   Q6Mr+ODxE99F4oVr1vpbnn+x5qLPYW0A3ycr0lbI1azgYLYTUW+pglTOB
   Q==;
IronPort-SDR: GpsNxMAA/ioOM0RVQqAhzSr/4bnRGCtphhyhoaPuV9eoRL84Qlj3l2bFp1ZfL4aTtiQDWA0Vcz
 78leWMRdTHWoebpd9bUR4EUzrojRUQ0rDQB364883EyrWg8nLgMY3d+MSHDlKAZrvEwJ0dq1qc
 dAPD4GR68vy+ckaupy3TxBgvA/SyExoiQ2dbVGv8/iO6ToRxKSf4EkDP2HaVcKWBsu2OGg8XJ0
 6BfxDP94u959IUQitwnK+n4DUwg5JvJyH+TWpdMbaUNXffSmtcgGragRuS6aZGI1dXpxn23p7l
 rqo=
X-IronPort-AV: E=Sophos;i="5.82,331,1613404800"; 
   d="scan'208";a="168794691"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 20:11:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyxRTPvts2RrkVLLwOzr3YEk8C2tB4Yev6y+MKFYO1La4KZOpvTziAN0O0EPtvOWNNmRm0QeMbL97mEYblkDZsXKW3rCAaXf4gr9s2xBnVjGmVS7t7kIRJAAZFFxoYb2+udUqkoUehGPMSIWajvHheVsi3J9YMnpysMlogAIjTqNu8x5zXRFXI4j57aIhco5yF7ZGgEDoulzPDSvDTC8mljzCIgoAIJKGfWe2xqo3ywxlQ5z0RXC2e8RQ8dvqJfVsMM7zA2955R8mdR2H+a29Nk3mgQ8a/TaTKr3NYRHQd1VVVrrkoD+zWJCDmz8FT2H2B7nc1r5pMheeOKlQpQ0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KORs6cDMaNRwjkFnu9T8O4YkFG6aDMtvzAGQf6LxvrU=;
 b=PT2omP1+QUKHQ9ZeWa4jTw4fgBo0gpV+H3pgclgamykbKftdKM1ZK7lW0hL1TW38OyyECiYSzAChiHwzfS3P75LuueKGQab+aMmbNoBg63R6M6S4KTvWPqVHfesRMxVbJgw0QZX+URTiAYaOPSuqOaIE07f+t2rFuTMmbUzmV1cNz3uUcDnqqD3JxTmcXItsEIl0NWD2jRFZadQdhmhW5eykKvUTMTkbLfdfIdpqU5X3RYcxZCPwdDDq4TU5vfXgRrXjbj4zJ+1jUEp4XSD7bwFyqKCQu8CjxaXqlXTT5HoU76ceR3m78UAQqdFi+ijhMscwjZONH00Tln62W5faGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KORs6cDMaNRwjkFnu9T8O4YkFG6aDMtvzAGQf6LxvrU=;
 b=BE9nUJ9CiXLIW45LOG2BqxSJUyD4+psg5dCeZFjQb3FMGNmHyTedTmjzq7vhdviPa+my6AzjAmffhvvG7+BpntcZahLeBmBsbVlqzUXpxxe4afHNosYBRI1VxbMouM6H7Z1CdV4UJmwOzn1Ci5FdR5lEFkFHWn8Vuf/7DzTCziQ=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5995.namprd04.prod.outlook.com (2603:10b6:5:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 12:11:43 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.020; Wed, 26 May 2021
 12:11:43 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 04/13] mm: Add functions to lock invalidate_lock for two
 mappings
Thread-Topic: [PATCH 04/13] mm: Add functions to lock invalidate_lock for two
 mappings
Thread-Index: AQHXUW0PB1DDoKdbbkudtJQ756uiLQ==
Date:   Wed, 26 May 2021 12:11:43 +0000
Message-ID: <DM6PR04MB7081EBE7CE3404AB53F62795E7249@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210525125652.20457-1-jack@suse.cz>
 <20210525135100.11221-4-jack@suse.cz> <20210525204805.GM202121@locust>
 <20210526100702.GB30369@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:11c4:96fb:3c8e:5a63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdb28495-13b5-49b7-f647-08d9203f6d4d
x-ms-traffictypediagnostic: DM6PR04MB5995:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM6PR04MB599597759AB6C006F60D60C4E7249@DM6PR04MB5995.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0lwiJaJ0yxdrkgx/qZ5t3p31kR6ZelWKcXYm1R3aKb2h08BsOpmDsoYfzaCagNRBxqX9XR2Fs7SenY6qSqCWSScTR/+vwy17QnHj0glm6azPyMBBtNtZJI0vhxhKu8k9VPFZFmRo8kFemIzcJvhifpywG0xhNzpXkFzuoQp809UFA2XwE4h0+e3SpuD4Rm+BUrNnMTS1QP5/1Uz2LCyaPI0dXuvVF81Wpz2p5z5VTNGaaCo7vkWJ2GQaCAqAb7nHgLdC3QPstVnD1RW7fVECyxsTSHBwnoQE7kfHsOkr3YTneUfUGUsg7QCptmRPOJi7WsVeONUHVkwVqWGkaC2QdoBNoLVBKUGGn/97K1sHzBrkCzPiEcxQ7a1U5o2V0pnr9kRffdVsFqa2STYyQtDJacSBBDgTnCdG81C2TqWnfbBSEx2Ipu7kmaLMgrh78NWminmHdP6OaD+fi1YjoIFHD1JRAuBcoVwxURTCc5CUn9+ReygkbL/rNgAQPH5r1SPfdmzELpomfjdNgcTx5Bvz3tUFE3eDwOPq1NKW/PtP2SuWvI9xyYqbYd9EvIz+qh0OTfK0ndaB5C7KQMCbbt+6Q8oqfBN5BoimDCtuvU68rKE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(376002)(136003)(346002)(396003)(6506007)(7416002)(316002)(4326008)(478600001)(186003)(66946007)(71200400001)(53546011)(9686003)(83380400001)(2906002)(55016002)(5660300002)(122000001)(86362001)(76116006)(91956017)(8936002)(66476007)(66556008)(66446008)(64756008)(52536014)(38100700002)(8676002)(110136005)(7696005)(54906003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MJfxghB0mOToMvacjsrlAIlfBgcuoJYGLTwhNLFfYGQPF8mdbKRHWl7J+rY8?=
 =?us-ascii?Q?Zb+dXSOHTVbkYa2Gm5TTsE7yOLMOe4YJP7jtLOQfGmCww+AZVH6wUHR2zAOj?=
 =?us-ascii?Q?yQ1XE/pSHQkxE8EYFw9pDk7A63/GqwUAvrNZSe0gZpQ0g2D/jJtKdNu6M96B?=
 =?us-ascii?Q?vao8+dl5EQ1l5f9bPg01tv0O/1TjPPIrXNP0Z1c2M7QSZ+BKoYJOk7aEHYy/?=
 =?us-ascii?Q?K6H9/9uMAiFL6vbsAVcmfg6WYSrfoXqTYC1H67rD3nzBaYcQFZOyb78h6Fx9?=
 =?us-ascii?Q?NrgE/RS8rz4uhhhzDxAqDBl+3Tjs4w4q/EhPKte4aDwQBCGpNpTuKHU+GoHb?=
 =?us-ascii?Q?7vZaF4mZYbUx0QYTecu54VihUtHYO5eU8a2lj3brQuVBOyJ5NGh1z8tOqVsl?=
 =?us-ascii?Q?VvCKEUk84AIWBmMZ7V4SeHNmZoRA+sHQxc2gFW/vuR41Y7BQeheH1n3dv0Sn?=
 =?us-ascii?Q?i+s5dtn+O4tbvz2N0ddEMHHDO4PJNtia0fC8uAeiH6+Gs+26JjuzPgrzpUZT?=
 =?us-ascii?Q?8GMxwaVmfZcXbEL6A28VGu7k8g3PSbZrlSPFZDjpiK6dyG/B/DMBvZyvjXZf?=
 =?us-ascii?Q?XTKSTzEua/AqxXeaaOg2uKrf4OoZu51RnYlIzhC7vGMsQcjmdsNe1OHHrmoM?=
 =?us-ascii?Q?Fek6cIXg9H4ZOFh9QSrs5jKI4IrHotNsnOwT8LtFCX9Rnm8tlNhDd/hj2/S9?=
 =?us-ascii?Q?Efnj3NRQhwdKcMUYV1HkyuZ7O1rZc7wJLznimpCmehA6IiVtDpKotOvCOiRB?=
 =?us-ascii?Q?RfPZZdieaiZpEri+pcYRAIj4eFsf8pKYhBE/JHzB/q8PoMkd6cp3ZdiWWTob?=
 =?us-ascii?Q?8QvKwbmjj4kM+KwzqhKe/wE+1SZLFsD0sPpzppcluzdComQyXmmDtDvYSJyQ?=
 =?us-ascii?Q?25ukmCzEqqdhkbxsdGdR11Gwpeh5Kb0fl6BL3Zo/JdcgmhoLUlGUROxoqMi2?=
 =?us-ascii?Q?0NKIB/Q1A5BVzLoqd5UHKq9FTf3vhPHxYFoThy8U8wAUU0PYupYd3HI5XLTE?=
 =?us-ascii?Q?U6csvSptmMhoM7cWavMTtSILRt7EHDsZz8EEwtezb9Ia+w+2M8CJN3+lwhKG?=
 =?us-ascii?Q?r2dScGtKnS9wKlXz0uJvxSQcAFQdmEOHdCRpA61XKZYFN972bNFRGhaLFUC+?=
 =?us-ascii?Q?ebxBP0mOYuUpyhLD5uuVTiEvacW/tiR+EuIG033VwmZffRv14Rk/iez2GO0E?=
 =?us-ascii?Q?0BP9ATGD9b/wJOuGrqw5mQbblvrIRB2tK3lc0hsShouTTNcSCHmk7HvSu4z1?=
 =?us-ascii?Q?62oGL7A+8paeBedD+IHNCsG+DKQ1Exf2U3WZK6ykmJ3Ql67c9T/UtHhS0G44?=
 =?us-ascii?Q?9kYDME6t/i20NS1XXHSXdb/5gWizEptq1NVGuVUfJjOShFmnk8zaVVpCxx9S?=
 =?us-ascii?Q?IjDfBWsoj8gzZAkcBcXYJ6mqmDT33UtqPh+5X5zTGwohzuGz+g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb28495-13b5-49b7-f647-08d9203f6d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 12:11:43.7066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVc1dAwFaGj5Ta5zGOOBGnsk7Aqfocn0DcFT67KOjwNBHSQBKH9d1f9P7d1VSIotitd3WRMTx1w8PXf+6c+ecQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5995
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/05/26 19:07, Jan Kara wrote:=0A=
> On Tue 25-05-21 13:48:05, Darrick J. Wong wrote:=0A=
>> On Tue, May 25, 2021 at 03:50:41PM +0200, Jan Kara wrote:=0A=
>>> Some operations such as reflinking blocks among files will need to lock=
=0A=
>>> invalidate_lock for two mappings. Add helper functions to do that.=0A=
>>>=0A=
>>> Signed-off-by: Jan Kara <jack@suse.cz>=0A=
>>> ---=0A=
>>>  include/linux/fs.h |  6 ++++++=0A=
>>>  mm/filemap.c       | 38 ++++++++++++++++++++++++++++++++++++++=0A=
>>>  2 files changed, 44 insertions(+)=0A=
>>>=0A=
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h=0A=
>>> index 897238d9f1e0..e6f7447505f5 100644=0A=
>>> --- a/include/linux/fs.h=0A=
>>> +++ b/include/linux/fs.h=0A=
>>> @@ -822,6 +822,12 @@ static inline void inode_lock_shared_nested(struct=
 inode *inode, unsigned subcla=0A=
>>>  void lock_two_nondirectories(struct inode *, struct inode*);=0A=
>>>  void unlock_two_nondirectories(struct inode *, struct inode*);=0A=
>>>  =0A=
>>> +void filemap_invalidate_down_write_two(struct address_space *mapping1,=
=0A=
>>> +				       struct address_space *mapping2);=0A=
>>> +void filemap_invalidate_up_write_two(struct address_space *mapping1,=
=0A=
>>=0A=
>> TBH I find myself wishing that the invalidate_lock used the same=0A=
>> lock/unlock style wrappers that we use for i_rwsem.=0A=
>>=0A=
>> filemap_invalidate_lock(inode1->mapping);=0A=
>> filemap_invalidate_lock_two(inode1->i_mapping, inode2->i_mapping);=0A=
> =0A=
> OK, and filemap_invalidate_lock_shared() for down_read()? I guess that=0A=
> works for me.=0A=
=0A=
What about filemap_invalidate_lock_read() and filemap_invalidate_lock_write=
() ?=0A=
That reminds the down_read()/down_write() without the slightly confusing do=
wn/up.=0A=
=0A=
> =0A=
> 								Honza=0A=
> =0A=
>  =0A=
>> To be fair, I've never been able to keep straight that down means lock=
=0A=
>> and up means unlock.  Ah well, at least you didn't use "p" and "v".=0A=
>>=0A=
>> Mechanically, the changes look ok to me.=0A=
>> Acked-by: Darrick J. Wong <djwong@kernel.org>=0A=
>>=0A=
>> --D=0A=
>>=0A=
>>> +				     struct address_space *mapping2);=0A=
>>> +=0A=
>>> +=0A=
>>>  /*=0A=
>>>   * NOTE: in a 32bit arch with a preemptable kernel and=0A=
>>>   * an UP compile the i_size_read/write must be atomic=0A=
>>> diff --git a/mm/filemap.c b/mm/filemap.c=0A=
>>> index 4d9ec4c6cc34..d3801a9739aa 100644=0A=
>>> --- a/mm/filemap.c=0A=
>>> +++ b/mm/filemap.c=0A=
>>> @@ -1009,6 +1009,44 @@ struct page *__page_cache_alloc(gfp_t gfp)=0A=
>>>  EXPORT_SYMBOL(__page_cache_alloc);=0A=
>>>  #endif=0A=
>>>  =0A=
>>> +/*=0A=
>>> + * filemap_invalidate_down_write_two - lock invalidate_lock for two ma=
ppings=0A=
>>> + *=0A=
>>> + * Lock exclusively invalidate_lock of any passed mapping that is not =
NULL.=0A=
>>> + *=0A=
>>> + * @mapping1: the first mapping to lock=0A=
>>> + * @mapping2: the second mapping to lock=0A=
>>> + */=0A=
>>> +void filemap_invalidate_down_write_two(struct address_space *mapping1,=
=0A=
>>> +				       struct address_space *mapping2)=0A=
>>> +{=0A=
>>> +	if (mapping1 > mapping2)=0A=
>>> +		swap(mapping1, mapping2);=0A=
>>> +	if (mapping1)=0A=
>>> +		down_write(&mapping1->invalidate_lock);=0A=
>>> +	if (mapping2 && mapping1 !=3D mapping2)=0A=
>>> +		down_write_nested(&mapping2->invalidate_lock, 1);=0A=
>>> +}=0A=
>>> +EXPORT_SYMBOL(filemap_invalidate_down_write_two);=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * filemap_invalidate_up_write_two - unlock invalidate_lock for two ma=
ppings=0A=
>>> + *=0A=
>>> + * Unlock exclusive invalidate_lock of any passed mapping that is not =
NULL.=0A=
>>> + *=0A=
>>> + * @mapping1: the first mapping to unlock=0A=
>>> + * @mapping2: the second mapping to unlock=0A=
>>> + */=0A=
>>> +void filemap_invalidate_up_write_two(struct address_space *mapping1,=
=0A=
>>> +				     struct address_space *mapping2)=0A=
>>> +{=0A=
>>> +	if (mapping1)=0A=
>>> +		up_write(&mapping1->invalidate_lock);=0A=
>>> +	if (mapping2 && mapping1 !=3D mapping2)=0A=
>>> +		up_write(&mapping2->invalidate_lock);=0A=
>>> +}=0A=
>>> +EXPORT_SYMBOL(filemap_invalidate_up_write_two);=0A=
>>> +=0A=
>>>  /*=0A=
>>>   * In order to wait for pages to become available there must be=0A=
>>>   * waitqueues associated with pages. By using a hash table of=0A=
>>> -- =0A=
>>> 2.26.2=0A=
>>>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
