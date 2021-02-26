Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9037D325CA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBZEk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:40:56 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54429 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBZEkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614314454; x=1645850454;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Y2vpmDNiSjtvuxvt6EMqmExDnfBVOMBYgoyv1n9jOls=;
  b=Vrjm3Eyw23Q8HgZpguyG+2yIZnmAJ1lWyJM0swiiW9MSZq6uLOPanGnE
   +OLW9k5edkIGP6c/KAUapL8IIdwKv/ByjvdlV7rsGrpMPkq67bsDDSTl8
   r5TKlTXjo1eavHozod+/8XFXaSLS/5vo2MWEJFcoLDZ2ofud220zQ5i6r
   lVBRUTu04Sjp5Eni8XkLCkv0YGIGdrY7jsiR1cOOwdZqK2J0saHZYAbTW
   ZGgP69aXFe1JPzSn742Pgmxaw6MtEMFL6OncFQWJ7wjw9YwKl5hrDv4+J
   8isK5mn8tgzfVoLkPnEcevC0nN2gwRoR47VUgdyRONeLqT/iLJzKqScQa
   A==;
IronPort-SDR: V3yqvYF7dTjt9yJBy1vMU5lmUwK8CmC+kP9zZRdYtqqScWTvF0QblXtC3Jscw9wjlyWO+Wrlts
 dYAkbYT/26kUPMGlsKSo5rgQgwSSlws7DDF69KPvDIYFf8/Dn7NunEW+HupOrkuDNS9bI8UuW/
 e9tEPvcGNu8z7OA+obBWQpBCht6DWe1sxVjsbHDGfet6rDPMt1Sk+M518NmVGqoclXEMq9hBfU
 0q0mcTsyK+tJ3I2rKkzxlzklEOTd5r6VkS4kMFh0DrKqCQAx463DzbuliPxyJv4atXtXTDSFej
 Fcc=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="162024531"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:39:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7KvNV2pTB3xJdH7FkTaTMCGNiwCUgpp15rsDallVh1A6CU/A9jy22V0crBlt54Jgob8rtO8DgnoNJT6RpaOqD9ZjiFOW7QucsquxvMXSp20HlRA8Jwiig9dMe/HTVm/MsTsHlcMF5uJbsq7I8Dk5bpJOtbg/SMrSDMJR2eUyyrrdcIKGhVNAm3owwJgPX3MlxnXLDncPs341eepMwKSwHWXN9J9FnUZU62xcuH7Tbv3SJ0zU/5iASYasBFs/tiwe6yczJVNMhhp5H+2LCbpS3JEXSR1OgbFgtP0CscMsvS6abyxwpP12SLjQTJ830HNw4PZ8tfVRnoLHpgLvqsfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHoMh7OYE5OpskeYjWm05I0lfxs8PBKAbvh2WNSD8dI=;
 b=GB3CMf/cq0FZ8rze2UKdvfWhOaO8iu0MwmOpq3mX4A09QfV8AJjOPo3N3xB71i4v9IwIqzsG+FEE6gq/BPYWE+qrz63rYQ79Yiy9IKNiXBe9mJa8D8ZzgY8Da3bW8X391/kpE9/kxqC306nbet3ZE6eHNLjIkJwNrPA3tPlVQDncmVQmncYAOvZMdhhv0dzwwnyyxsGnQn28q8hncglRabGwkcZx5XiaFBkWdnYZFy8TAdTR4e6Lh/hKQWcY4BXFyC/iyEb77U/2A5G5s/Fldkuf5WEN69wv00FaNKH6gShuSE3pXgEw8eTMBG6wTOPLbL1e54y0eMzLY7+s9Y6DaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHoMh7OYE5OpskeYjWm05I0lfxs8PBKAbvh2WNSD8dI=;
 b=lU1gIbJumbMXGr+vu6X0JJUvzn26L+uOxGCio3db4bOpljhHGWXrg+spWlmpghDMbCw2YZBFIUhz+SHQTaFWcJO4W9kuvFh2dNusgWi5hKonEYgOZpx+mPxiBUpexQmj6RGZjfdUOjpCxzMAywMEKD/fNkgaVKpeo2r6yDF66h8=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4531.namprd04.prod.outlook.com (2603:10b6:208:44::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Fri, 26 Feb
 2021 04:39:47 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:39:47 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 05/39] blktrace: add trace note APIs
Thread-Topic: [RFC PATCH 05/39] blktrace: add trace note APIs
Thread-Index: AQHXC0RV7ajFwHlbhEKbIbTApxDXYA==
Date:   Fri, 26 Feb 2021 04:39:46 +0000
Message-ID: <BL0PR04MB651468D6766C8D6A6DAF21B2E79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-6-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87efe87a-b4d6-4e6f-be29-08d8da108ba7
x-ms-traffictypediagnostic: BL0PR04MB4531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4531572106B4FB797D4F2F14E79D9@BL0PR04MB4531.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IpSTVvbHfzDwAJ/E4tWpq8Mixcc0l2aisQw6St1Q+YNAv0+bmWZr+h9bJyH6+i1GR9Her5b/t2FaScZQwh41UGyNIUk/wpl8gizx/14zTBF+en5H/6PPsDEoNxC5ojPHPNSci0ufUAEo9HsMJV0Ob0IUdeXXfywsILmdYknIyVS18X3sRiGC38dLWxhwDlllSeMzbBIKeL63UubEDmX61OqyT6m/PIJ6NRBL9IQq2NO4b8Zqvd3jcdpBXb/0d+c/wQCONgAFRm8B5E7pt8Fo0xF/zlz4PmCQGEGLcf2u3Cb9u9FHqPMWmykOYi9A3Mhw76ddpDTYy57DPK7sWH0VCdXrWxqeOXiXQGdy0GVY4Iufr+8/tGdW2eRzCuVi56JMZPK0xEzpetV45jmA03CGOcYiALDQqFZxDmiZ79+Kd1dU9S7v9z5sD/ZXwntvO1huTrjWwg4fd8fl8euA8NzYD1LQP+gLWr5FUrVWP8UKxYNXFBzPNwJX4VLJFR08KLq+lh6TlF8yzYfhXEBIIv7HLuisEmTmGvZ2iygktiaLUeGMHOukliF55A+ty47q4PuTrdgfNS+YFGBZ7ryVW+s6yA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(71200400001)(921005)(66556008)(478600001)(66446008)(66476007)(91956017)(4326008)(186003)(8676002)(5660300002)(2906002)(76116006)(6506007)(52536014)(7416002)(64756008)(53546011)(316002)(9686003)(8936002)(33656002)(7696005)(86362001)(54906003)(83380400001)(66946007)(110136005)(55016002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UVwRYoj6VCILn7WTEvgJ0AEdxu2UaCliVYwjMjjThpd+JMjE3BCQhDCbCvUY?=
 =?us-ascii?Q?NxQaXvcnFUe3wMRk1JkIRYkd1x/s5ahksAAeyQt82BGiC278br0ggEwuxaWA?=
 =?us-ascii?Q?ui+GLLM41gI0LuNFUd/qCBPEBGEskLz51NloMfCoM4gjgcR0dvh0rEsz1qlH?=
 =?us-ascii?Q?pIXBIRqjETtqcKMqs5KpZaCnjW/bOrmmMXB2WQ6VOvzomzrVNSu/1kiH51zz?=
 =?us-ascii?Q?4wrr0WyVyvHCb1JiFtdLg3EQgTpcVOP+fTNSieKFKVFsDI+2KzXd9p5UbBvi?=
 =?us-ascii?Q?kJeA9L+QoISDIe3yS3IumQN0qQf4NFb9YWIw0M3Az0NurFZ7P2xvsaxW7SH5?=
 =?us-ascii?Q?EGY+IGA1GM6Cb52YScW1SBcVE4sCoylQN9XejsNrmdGEFQUr2zPNq88MmMee?=
 =?us-ascii?Q?x2zPnaGNl2mPDXA3xYVXiwky+H4LIpDxjG9GBtvlgXRG0a1hH/NN5aOFbZME?=
 =?us-ascii?Q?qtC/Eb6TuMKzD3HYqcBw1n0FbjHFtW3JHv/ENgWP9OBhFl6Nl29JnimLyKK/?=
 =?us-ascii?Q?AT2JjXamehcE3a+7igc/TOXsf3+e/3KZ9Y80aRSfmBHy3ENQbtyxT/Y11C19?=
 =?us-ascii?Q?hERce9h8g3HEVhu04TmebVsOPFjesuabhei8yV/0U7x5iviOl7rkti73ZQvt?=
 =?us-ascii?Q?CfCEKYWjSkaCXAvqxM85Gt0T/irQ3XUAFq/9effvPRBa+Z12JH2MLKnwBSYr?=
 =?us-ascii?Q?DEUahFg73lBydvN3OYwQz4yLZsmW4BiUkRN6eeAe5VUPL19FAdUmWCD4RMzo?=
 =?us-ascii?Q?FGsk6K15AgdvysNfnG0YR3zjRyoAF0Sj0BrkmLCLmCVAevXnvnwbLT4B7Q0V?=
 =?us-ascii?Q?DHHoEhkM+Xi/G+CPcHasCIdjefG4vobi7y0foDVQn0pDiZQEXkc+HO4o4kAu?=
 =?us-ascii?Q?MEa7pkFfDPcXe5bOwPOfZJD/FGj5HTggzwk/bB1PNnMqFPZlvII7r9PFQ/gn?=
 =?us-ascii?Q?yk0Tas6f/G8HJp8kPgyPfFwQZEQAX/L4FbYrwgNX2W/3oSurkcB/bso0CmEz?=
 =?us-ascii?Q?69TDZXqFisS5xoBl7wz7baEV+0Jw4ZmzfMQHRO8kJmHswxLaofa1ltP7g9gK?=
 =?us-ascii?Q?UwzTzDXtOdFLgZv/TZhZvHA/+86LXT8a0WUwlcBktNUqdE8QUwb8mtsLRDHd?=
 =?us-ascii?Q?lDjMFCF7Yji670a5f8Ut7XtYYW1wvOzeCICcHP6xPuN5U/m3+8GDP96s46CM?=
 =?us-ascii?Q?J+6bxf8b5h5kMra8Flkve7xRkGTPCxf21VJqcL/QR70Qwc5aQpmOxcTOXsTU?=
 =?us-ascii?Q?R5Nvxfs6fr//t4G0wwDjdcvrM5u5DcMORTuwlDRCt3SQuk112Ux73hZOfrrt?=
 =?us-ascii?Q?q39tdRhWxX4rd82jXzgt+61l9HCb5G8owliKcEb9b8Yt/bkEgvGebFwXGJ0B?=
 =?us-ascii?Q?FhrcZ7wrEoffjGkMYBWgCGs1eqrOC8Ao7fhL6ypAsmLYdyhFTQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87efe87a-b4d6-4e6f-be29-08d8da108ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:39:46.8988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBRYRCxo88IECZdA2Zww4woFshPDdF5y78yK2CO/0qSlMEiImjfj1fPCK3IyK0wN0tzH8Cp7hj6sJCcsEFHRPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4531
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No commit message. Add one please.=0A=
=0A=
On 2021/02/25 16:03, Chaitanya Kulkarni wrote:=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  kernel/trace/blktrace.c | 113 ++++++++++++++++++++++++++++++++++++++++=
=0A=
>  1 file changed, 113 insertions(+)=0A=
> =0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index e45bbfcb5daf..4871934b9717 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -114,6 +114,52 @@ static void trace_note(struct blk_trace *bt, pid_t p=
id, int action,=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> +static void trace_note_ext(struct blk_trace_ext *bt, pid_t pid, u64 acti=
on,=0A=
> +			   const void *data, size_t len, u64 cgid, u32 ioprio)=0A=
> +{=0A=
> +	struct blk_io_trace_ext *t;=0A=
> +	struct ring_buffer_event *event =3D NULL;=0A=
> +	struct trace_buffer *buffer =3D NULL;=0A=
> +	int pc =3D 0;=0A=
> +	int cpu =3D smp_processor_id();=0A=
> +	bool blk_tracer =3D blk_tracer_enabled;=0A=
> +	ssize_t cgid_len =3D cgid ? sizeof(cgid) : 0;=0A=
> +=0A=
> +	if (blk_tracer) {=0A=
> +		buffer =3D blk_tr->array_buffer.buffer;=0A=
> +		pc =3D preempt_count();=0A=
> +		event =3D trace_buffer_lock_reserve(buffer, TRACE_BLK,=0A=
> +						  sizeof(*t) + len + cgid_len,=0A=
> +						  0, pc);=0A=
> +		if (!event)=0A=
> +			return;=0A=
> +		t =3D ring_buffer_event_data(event);=0A=
> +		goto record_it;=0A=
> +	}=0A=
> +=0A=
> +	if (!bt->rchan)=0A=
> +		return;=0A=
> +=0A=
> +	t =3D relay_reserve(bt->rchan, sizeof(*t) + len + cgid_len);=0A=
> +	if (t) {=0A=
> +		t->magic =3D BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION_EXT;=0A=
> +		t->time =3D ktime_to_ns(ktime_get());=0A=
> +record_it:=0A=
> +		t->device =3D bt->dev;=0A=
> +		t->action =3D action | (cgid ? __BLK_TN_CGROUP : 0);=0A=
> +		t->ioprio =3D ioprio;=0A=
> +		t->pid =3D pid;=0A=
> +		t->cpu =3D cpu;=0A=
> +		t->pdu_len =3D len + cgid_len;=0A=
> +		if (cgid_len)=0A=
> +			memcpy((void *)t + sizeof(*t), &cgid, cgid_len);=0A=
> +		memcpy((void *) t + sizeof(*t) + cgid_len, data, len);=0A=
> +=0A=
> +		if (blk_tracer)=0A=
> +			trace_buffer_unlock_commit(blk_tr, buffer, event, 0, pc);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Send out a notify for this process, if we haven't done so since a tra=
ce=0A=
>   * started=0A=
> @@ -132,6 +178,20 @@ static void trace_note_tsk(struct task_struct *tsk)=
=0A=
>  	spin_unlock_irqrestore(&running_trace_lock, flags);=0A=
>  }=0A=
>  =0A=
> +static void trace_note_tsk_ext(struct task_struct *tsk, u32 ioprio)=0A=
> +{=0A=
> +	unsigned long flags;=0A=
> +	struct blk_trace_ext *bt;=0A=
> +=0A=
> +	tsk->btrace_seq =3D blktrace_seq;=0A=
> +	spin_lock_irqsave(&running_trace_ext_lock, flags);=0A=
> +	list_for_each_entry(bt, &running_trace_ext_list, running_ext_list) {=0A=
> +		trace_note_ext(bt, tsk->pid, BLK_TN_PROCESS_EXT, tsk->comm,=0A=
> +			   sizeof(tsk->comm), 0, ioprio);=0A=
> +	}=0A=
> +	spin_unlock_irqrestore(&running_trace_ext_lock, flags);=0A=
> +}=0A=
> +=0A=
>  static void trace_note_time(struct blk_trace *bt)=0A=
>  {=0A=
>  	struct timespec64 now;=0A=
> @@ -148,6 +208,22 @@ static void trace_note_time(struct blk_trace *bt)=0A=
>  	local_irq_restore(flags);=0A=
>  }=0A=
>  =0A=
> +static void trace_note_time_ext(struct blk_trace_ext *bt)=0A=
> +{=0A=
> +	struct timespec64 now;=0A=
> +	unsigned long flags;=0A=
> +	u32 words[2];=0A=
> +=0A=
> +	/* need to check user space to see if this breaks in y2038 or y2106 */=
=0A=
> +	ktime_get_real_ts64(&now);=0A=
> +	words[0] =3D (u32)now.tv_sec;=0A=
> +	words[1] =3D now.tv_nsec;=0A=
> +=0A=
> +	local_irq_save(flags);=0A=
> +	trace_note_ext(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), 0, 0);=0A=
> +	local_irq_restore(flags);=0A=
> +}=0A=
> +=0A=
>  void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,=0A=
>  	const char *fmt, ...)=0A=
>  {=0A=
> @@ -185,6 +261,43 @@ void __trace_note_message(struct blk_trace *bt, stru=
ct blkcg *blkcg,=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(__trace_note_message);=0A=
>  =0A=
> +void __trace_note_message_ext(struct blk_trace_ext *bt, struct blkcg *bl=
kcg,=0A=
> +	const char *fmt, ...)=0A=
> +{=0A=
> +	int n;=0A=
> +	va_list args;=0A=
> +	unsigned long flags;=0A=
> +	char *buf;=0A=
> +=0A=
> +	if (unlikely(bt->trace_state !=3D Blktrace_running &&=0A=
> +		     !blk_tracer_enabled))=0A=
> +		return;=0A=
> +=0A=
> +	/*=0A=
> +	 * If the BLK_TC_NOTIFY action mask isn't set, don't send any note=0A=
> +	 * message to the trace.=0A=
> +	 */=0A=
> +	if (!(bt->act_mask & BLK_TC_NOTIFY))=0A=
> +		return;=0A=
> +=0A=
> +	local_irq_save(flags);=0A=
> +	buf =3D this_cpu_ptr(bt->msg_data);=0A=
> +	va_start(args, fmt);=0A=
> +	n =3D vscnprintf(buf, BLK_TN_MAX_MSG, fmt, args);=0A=
> +	va_end(args);=0A=
> +=0A=
> +	if (!(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))=0A=
> +		blkcg =3D NULL;=0A=
> +#ifdef CONFIG_BLK_CGROUP=0A=
> +	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n,=0A=
> +		blkcg ? cgroup_id(blkcg->css.cgroup) : 1, 0);=0A=
> +#else=0A=
> +	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n, 0, 0);=0A=
> +#endif=0A=
> +	local_irq_restore(flags);=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(__trace_note_message_ext);=0A=
> +=0A=
>  static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector=
,=0A=
>  			 pid_t pid)=0A=
>  {=0A=
> =0A=
=0A=
I fail to see why the xxx_ext functions need the different blk_trcae_ext=0A=
structure. It seems that everything should work with a modified blk_trace=
=0A=
structure. With such approach, a lot of the xxx_ext functions in here may n=
ot be=0A=
necessary at all. Simply change the interface of the existing note function=
s.=0A=
There are not that many call sites to change, right ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
