Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC656B56C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiGHJZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 05:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiGHJZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:25:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5B35FF1
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 02:25:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j12so9095104plj.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jul 2022 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l76lwu0gnwm/BRNuFyHSAOJEi0ORTe8+eknNAmXKjds=;
        b=rfzaFQGT5WylU8oFzZ3Bm68tK5cbUJbFE9StIG5s9hhsbRmfmyXpTX1vYAFS6j1sbO
         54fzhiZV7ncHK4Nr8HGnmkIfr2ytnO8L9enycMsyVsVIL1tiXZVpZqSpKlDbdzlr1hkY
         5SH3l1JlLCIaVKwtkJN3exq1MhVYULNmdtYE+3L2FEtWtbYyCTh7i5U27YS5hNLZS0Xi
         TkCdvF8KuNND6fSaeYKOvdHkBq2ajs61bZsAjRcCL57hyN0L81gtcBE6SGAlrMn1jLvp
         TQMFQ82Z2m2T8NG7gNKsoCwNbcmQba3/hsB+SpuTecMd4FglfijuRPwEi0zcwSVVDuyS
         /4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l76lwu0gnwm/BRNuFyHSAOJEi0ORTe8+eknNAmXKjds=;
        b=m5icPQYSYgZC0CiE4GZgii4I76efs+AmzIgJOy4jv64Xs+9/BgQRswmFk2GZUQ7hLO
         CAY9b58+uouRYeRI/hzQA+PLJwXdEibYeShaTmS3678xQKMF1mNcpazJLNkxpXl5MvKZ
         PkzDCTqmJEEkyMv1XXcFcOi9UJ9liBMOwsBLLR/kFCh91uxJQNj63fak1W0SehESSUIO
         fPPp2qqmXyXbFk0MyEd1M4S5Xk/vLRmyJOU3BS7wIJE+awJp0JIyC5HyfbVI1BlNDblr
         r2kJ2Iylpe1DZpw/tP/Ne9+edTqZVr6iEsuT5oM4BUdsmrI370W2KbNF12Q2EeXAhMrE
         dMCA==
X-Gm-Message-State: AJIora8zMSjDcHzdOUtf5iDv7zAcDVeFrGy3h2tXdg92FRPamVvrHq14
        usGodWzIFQyYDJzkQiCQkTReSA==
X-Google-Smtp-Source: AGRyM1uqbelvg6m24YuvTJPV4Xejv5UL/IUxXrRtbsELGOPhY6RycQiwGj2gryVPaBaHnMht6h77RQ==
X-Received: by 2002:a17:902:e80c:b0:16c:28a6:8aa0 with SMTP id u12-20020a170902e80c00b0016c28a68aa0mr422950plg.119.1657272345465;
        Fri, 08 Jul 2022 02:25:45 -0700 (PDT)
Received: from [10.255.210.8] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id z11-20020a1709027e8b00b0016b865ea2ddsm23212195pla.85.2022.07.08.02.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 02:25:44 -0700 (PDT)
Message-ID: <be9303de-3800-c26f-4530-9a29fe044956@bytedance.com>
Date:   Fri, 8 Jul 2022 17:25:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Re: [PATCH v2 0/5] mm, oom: Introduce per numa node oom for
 CONSTRAINT_{MEMORY_POLICY,CPUSET}
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, surenb@google.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        adobriyan@gmail.com, yang.yang29@zte.com.cn, brauner@kernel.org,
        stephen.s.brennan@oracle.com, zhengqi.arch@bytedance.com,
        haolee.swjtu@gmail.com, xu.xin16@zte.com.cn,
        Liam.Howlett@oracle.com, ohoono.kwon@samsung.com,
        peterx@redhat.com, arnd@arndb.de, shy828301@gmail.com,
        alex.sierra@amd.com, xianting.tian@linux.alibaba.com,
        willy@infradead.org, ccross@google.com, vbabka@suse.cz,
        sujiaxun@uniontech.com, sfr@canb.auug.org.au,
        vasily.averin@linux.dev, mgorman@suse.de, vvghjk1234@gmail.com,
        tglx@linutronix.de, luto@kernel.org, bigeasy@linutronix.de,
        fenghua.yu@intel.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org
References: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
 <YsfwyTHE/5py1kHC@dhcp22.suse.cz>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <YsfwyTHE/5py1kHC@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oh apologize. I just realized what you mean.

I should try a "cpuset cgroup oom killer" selecting victim from a
specific cpuset cgroup.

On 2022/7/8 16:54, Michal Hocko wrote:
> On Fri 08-07-22 16:21:24, Gang Li wrote:
> 
> We have discussed this in your previous posting and an alternative
> proposal was to use cpusets to partition NUMA aware workloads and
> enhance the oom killer to be cpuset aware instead which should be a much
> easier solution.
