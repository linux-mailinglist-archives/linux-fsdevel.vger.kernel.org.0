Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56948B540
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfHMKSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 06:18:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45673 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfHMKSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:18:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id x19so100519876eda.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 03:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sDvZYPX01qvJEk1mxVfvRbPwYZHJVjY2tZUcFvyfON8=;
        b=I51DKW+6rqBKOxjaMza1sK1VE/eMvLMnDfYqpm3c37vjB32hRS4IpKz8qcRsO54KCV
         N+RyXGN38/ApWPXt+El/EuW7RWRvHomc7YpmVPeQv++nyrQP+lIYaJV5dypDiU2ft4vG
         ZCQ35zN2UCMrqZTF0q7UhCpDVi10nk7aygk21RlqN4kbm0zLSFLM3emj8OW4mAAy7ZAL
         qv1y1F5RX7ymU3MmbQRui71pIC4rUexSAFNz5oP7TMWLSX4+BkDLf/zH0/zq2bRj6PUw
         Zq80T//JibuOU+xJtrx6ZQzDWLuA1IAKofXXh6QOctOaoUP1UshWAoAqYXZzNZdKVJ1c
         o79Q==
X-Gm-Message-State: APjAAAXI4FbZxfsc5u/ltDJwfGd+KybiX1quapIQFytHlUZD/9w/C7lM
        jyWd8SXqgLHV/+/6l6ll7d4=
X-Google-Smtp-Source: APXvYqywLp/hUJ0pKbiHDxYFYlnUsCPpTjf4y98naDu0jmwWoOv6exFSeyn884P9fkBlo4ZTD9HDzQ==
X-Received: by 2002:a17:906:a98b:: with SMTP id jr11mr34062839ejb.224.1565691522491;
        Tue, 13 Aug 2019 03:18:42 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.gmail.com with ESMTPSA id hh16sm17443777ejb.18.2019.08.13.03.18.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 03:18:41 -0700 (PDT)
Subject: Re: [PATCH 05/16] zuf: zuf-core The ZTs
To:     kbuild test robot <lkp@intel.com>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     kbuild-all@01.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Boaz Harrosh <boazh@netapp.com>
References: <20190812164244.15580-6-boazh@netapp.com>
 <201908131114.vDpupeQe%lkp@intel.com>
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <2c28147e-84e2-1ba3-047e-b32c967c8782@electrozaur.com>
Date:   Tue, 13 Aug 2019 13:18:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201908131114.vDpupeQe%lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/08/2019 06:24, kbuild test robot wrote:
> Hi Boaz,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc4]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Boaz-Harrosh/zuf-ZUFS-Zero-copy-User-mode-FileSystem/20190813-074124
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    fs/zuf/zuf-core.c: In function '_r_zufs_dispatch':
>>> fs/zuf/zuf-core.c:697:46: error: 'struct task_struct' has no member named 'cpus_allowed'; did you mean 'mems_allowed'?
>      cpumask_copy(&zt->relay.cpus_allowed, &app->cpus_allowed);
>                                                  ^~~~~~~~~~~~
>                                                  mems_allowed
>    fs/zuf/zuf-core.c:698:21: error: 'struct task_struct' has no member named 'cpus_allowed'; did you mean 'mems_allowed'?
>      cpumask_copy(&app->cpus_allowed,  cpumask_of(smp_processor_id()));
>                         ^~~~~~~~~~~~
>                         mems_allowed
>    fs/zuf/zuf-core.c:721:22: error: 'struct task_struct' has no member named 'cpus_allowed'; did you mean 'mems_allowed'?
>       cpumask_copy(&app->cpus_allowed, &zt->relay.cpus_allowed);
>                          ^~~~~~~~~~~~
>                          mems_allowed


Thank you.

This code is based on v5.2. I guess something changed since 5.3-rc(s)
I will try to merge v5.3-rc4 and see how to fix this issue.
[I will send a SQUASHME patch on top of the original patch]

Would you prefer to add my github tree to the build or you
will apply the fixup patches onto?

Thank you for the report
Boaz

> 
> vim +697 fs/zuf/zuf-core.c
> 
>    643	
>    644	int __zufc_dispatch(struct zuf_root_info *zri, struct zuf_dispatch_op *zdo)
>    645	#endif /* CONFIG_ZUF_DEBUG */
>    646	{
>    647		struct task_struct *app = get_current();
>    648		struct zufs_ioc_hdr *hdr = zdo->hdr;
>    649		int cpu;
>    650		struct zufc_thread *zt;
>    651	
>    652		if (unlikely(hdr->out_len && !hdr->out_max)) {
>    653			/* TODO: Complain here and let caller code do this proper */
>    654			hdr->out_max = hdr->out_len;
>    655		}
>    656	
>    657		if (unlikely(zdo->__locked_zt)) {
>    658			zt = zdo->__locked_zt;
>    659			zdo->__locked_zt = NULL;
>    660	
>    661			cpu = get_cpu();
>    662			/* FIXME: Very Pedantic need it stay */
>    663			if (unlikely((zt->zdo != zdo) || cpu != zt->no)) {
>    664				zuf_warn("[%ld] __locked_zt but zdo(%p != %p) || cpu(%d != %d)\n",
>    665					 _zt_pr_no(zt), zt->zdo, zdo, cpu, zt->no);
>    666				put_cpu();
>    667				goto channel_busy;
>    668			}
>    669			goto has_channel;
>    670		}
>    671	channel_busy:
>    672		cpu = get_cpu();
>    673	
>    674		if (!_try_grab_zt_channel(zri, cpu, &zt)) {
>    675			put_cpu();
>    676	
>    677			/* If channel was grabbed then maybe a break_all is in progress
>    678			 * on a different CPU make sure zt->file on this core is
>    679			 * updated
>    680			 */
>    681			mb();
>    682			if (unlikely(!zt->hdr.file)) {
>    683				zuf_err("[%d] !zt->file\n", cpu);
>    684				return -EIO;
>    685			}
>    686			zuf_dbg_err("[%d] can this be\n", cpu);
>    687			/* FIXME: Do something much smarter */
>    688			msleep(10);
>    689			if (signal_pending(get_current())) {
>    690				zuf_dbg_err("[%d] => EINTR\n", cpu);
>    691				return -EINTR;
>    692			}
>    693			goto channel_busy;
>    694		}
>    695	
>    696		/* lock app to this cpu while waiting */
>  > 697		cpumask_copy(&zt->relay.cpus_allowed, &app->cpus_allowed);
>    698		cpumask_copy(&app->cpus_allowed,  cpumask_of(smp_processor_id()));
>    699	
>    700		zt->zdo = zdo;
>    701	
>    702	has_channel:
>    703		if (zdo->dh)
>    704			zdo->dh(zdo, zt, zt->opt_buff);
>    705		else
>    706			memcpy(zt->opt_buff, zt->zdo->hdr, zt->zdo->hdr->in_len);
>    707	
>    708		put_cpu();
>    709	
>    710		if (relay_fss_wakeup_app_wait(&zt->relay) == -ERESTARTSYS) {
>    711			struct zufs_ioc_hdr *opt_hdr = zt->opt_buff;
>    712	
>    713			opt_hdr->flags |= ZUFS_H_INTR;
>    714	
>    715			relay_fss_wakeup_app_wait_cont(&zt->relay);
>    716		}
>    717	
>    718		/* __locked_zt must be kept on same cpu */
>    719		if (!zdo->__locked_zt)
>    720			/* restore cpu affinity after wakeup */
>    721			cpumask_copy(&app->cpus_allowed, &zt->relay.cpus_allowed);
>    722	
>    723		DEBUG_CPU_SWITCH(cpu);
>    724	
>    725		return zt->hdr.file ? hdr->err : -EIO;
>    726	}
>    727	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

