Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132C44E3E30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 13:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiCVMNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 08:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiCVMNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:13:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B0814B7;
        Tue, 22 Mar 2022 05:12:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso2493591pjb.0;
        Tue, 22 Mar 2022 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IPjgN3VpyqWKrThD0C2Vv68XFS2hlHNg6yKh9JHRBog=;
        b=i4DYvQFQdyo/5cGeJC8YCDIAwZGR/35Ev0FGHGhqm4PmaXZhwqDqwpV56iN1d1CTjM
         VZcf5qQ2rZQuZD4p238kBM0r6GFWxmT0hhew6gUmKBqreUkeulpNBPqtI0nLW48qVUwX
         vgETrP1DEGJLzakL+r4z/w2UrP8Tc2xqJ2KFYBM1vP+8OEogx8uhjTC5shiNlXoTye9l
         skl36slIW/bDhZA+UWpwoWIBsUFLikYa+XVyNnhFIMM215ET9iW6u3r5K/lNbwcW7E4T
         LMl+gqC363rYdTVb4DO6hb5Y31gf65C5arsrIbHXymKFHP9IwLbGl+hNHlovnCTlcziL
         jw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IPjgN3VpyqWKrThD0C2Vv68XFS2hlHNg6yKh9JHRBog=;
        b=GknEa54wvS/NjUBeBfkD4rS6tuByYwO4/ImiIxwXuulQrNO7LcUwrd45ekYWulflwU
         3SHS/039+8W2eDZl5O/7xdI5Hc6zzTjG/3KiNmOfb2+iD8UTxDq05qZGeSt7uSayEUuq
         BIFgDJ1bbpZ+5Eqt1vjoU+wJfWwMuswCfIAHQ2nJtT9zJugDpAQjh7scOZGoiuCIrh5p
         73qAfMhRDtFFuoOy3ggrd2JuisOHoHwEs+PzrmKyCADULX5Wr2WqroVXxIqWxFE1MRty
         1fCykfySyDMcQyRSlnLYI7fAkhdyZw1Jk0ku15J1x8lEeTEPbK9QIlvIh5HBg2oYCyin
         RPjA==
X-Gm-Message-State: AOAM530oweC/AP/bb9Y0dby3mC76raz7nSkU88ydiec6yunI35sHEuVr
        P9lix1k4M/AiTgZs/Rd2BOU=
X-Google-Smtp-Source: ABdhPJxUF1F8+qJ3SlHYJaeCDF9cQ1MjbET2UM6ubThZHeCEwWI9y8r1CoVnmEtudVQLijl65PtVsg==
X-Received: by 2002:a17:902:b18a:b0:153:758e:c1 with SMTP id s10-20020a170902b18a00b00153758e00c1mr17757017plr.37.1647951145750;
        Tue, 22 Mar 2022 05:12:25 -0700 (PDT)
Received: from localhost.localdomain ([2409:4053:719:67ea:fc62:7f30:7002:e0c2])
        by smtp.googlemail.com with ESMTPSA id b20-20020a17090a991400b001befe07ae5csm2708380pjp.22.2022.03.22.05.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:12:25 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
Cc:     fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        dharamhans87@gmail.com, bshubert@ddn.com, amir73il@gmail.com
Subject: Re: [PATCH v2 0/2] FUSE: Atomic lookup + open performance numbers
Date:   Tue, 22 Mar 2022 17:42:12 +0530
Message-Id: <20220322121212.5087-1-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220322115148.3870-1-dharamhans87@gmail.com>
References: <20220322115148.3870-1-dharamhans87@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Subject: 'Re: [PATCH v2 0/2] FUSE: Atomic lookup + open performance numbers'

Thanks, Miklos. For measuring the performance, bonnie++ was used over passthrough_ll mount on tmpfs.
When taking numbers on vm, I could see non-deterministic behaviour in the results. Therefore core
binding was used for passthrough_ll and bonnie++, keeping them on separate cores.

Here are the google sheets having performance numbers.
https://docs.google.com/spreadsheets/d/1JRgF8DTR9xk5zz3_azmLcyy5kW3bgjjItmS8CYsAoT4/edit#gid=0
https://docs.google.com/spreadsheets/d/1JRgF8DTR9xk5zz3_azmLcyy5kW3bgjjItmS8CYsAoT4/edit#gid=1833203226

Following are the libfuse patches(commit on March 7 and March 8 in first link) which were used to test
these changes
https://github.com/aakefbs/libfuse/commits/atomic-open-and-no-flush
https://github.com/libfuse/libfuse/pull/644

Parameters used in mounting passthrough_ll:
 numactl --localalloc --physcpubind=16-23 passthrough_ll -f -osource=/tmp/source,allow_other,allow_root,
 cache=never -o max_idle_threads=1 /tmp/dest
     (Here cache=never results in direct-io on the file)

Parameters used in bonnie++:
In sheet 0B:
numactl --localalloc --physcpubind=0-7  bonnie++ -x 4 -q -s0  -d /tmp/dest/ -n 10:0:0:10 -r 0 -u 0 2>/dev/null

in sheet 1B:
numactl --localalloc --physcpubind=0-7 bonnie++ -x 4 -q -s0 -d /tmp/dest/ -n 10:1:1:10 -r 0 -u 0 2>/dev/null

Additional settings done on the testing machine:
cpupower frequency-set -g performance

Running bonnie++ gives us results for Create/s,  Read/s and Delete/s. Below table summarises the numbers
for  these three operations. Please note that for read of 0 bytes, bonnie++ does ops in order of create-open,
close and stat but no atomic open.  Therefore performance results  in the sheet 0B had overhead of extra
stat calls.  Whereas in sheet 1B, we directed bonnie++ to read 1 byte and this triggered atomic open call but
numbers for this run involve overhead for read operation itself instead of just plain open/close.

Here is the table summarising the performance numbers

Table: 0B
                                               Sequential                  |            Random
                                           Creat/s       Read/s    Del/s   |    Creat/s     Read/s      Del/s
Patched Libfuse                                -3.55%    -4.9%    -4.43%   |    -0.4%      -1.6%       -1.0%
Patched Libfuse + No-Flush                     +22.3%    +6%       +5.15%  |    +27.9%     +14.5%       +2.8%
Patched Libfuse + Patched FuseK                +22.9%    +6.1%     +5.3%   |    +28.3%     +14.5%       +2.3%
Patched Libfuse + Patched FuseK + No-Flush     +33.4%    -4.4%     -3.73%  |    +38.8%     -2.5%        -2.0%



 Table: 1B
                                                  Sequential                    |                  Random
                                           Create/s       Read/s       Del/s    |      Create/s     Read/s     Del/s
Patched Libfuse                            -0.22%        -0.35%       -0.7%     |      -0.27%        -0.78%    -2.35%
Patched Libfuse + No-Flush                 +2.5%         +2.6%        -9.6%     |      +2.5%         -8.6%     -6.26%
Patched Libfuse + Patched FuseK            +1.63%        -1.0%        -11.45%   |      +4.48%        -6.84%    -4.0%
Patched Libfuse + Patched FuseK + No-Flush  +32.43%      +26.61%      +076%     |      +33.2%       +14.7%     -0.40%

Here
No-Flush = No flush trigger from fuse kernel into libfuse

In Table 1B, we see 4th row has good improvements for both create and Read whereas Del seems to be almost not
changed. In Table 0B, 4th row we have Read perf reduced, it was found out that this was caused by some changes
in libfuse. So this was fixed and in Table 1B, same row, we can see increased numbers.

In Table 0B, 3rd row, we have good numbers because bonnie++ used 0 bytes to read  and this changed behaviour
and impacted perf whereas for the same row, Table 1B we have reduced numbers because it involved flush
calls for 1 byte from the fuse kernel into libfuse.

These changes are not for fuse kernel/users-space context switches only, but our main goal is to have improvement performance
for network file systems
   - Number network round trips
   - Reduce load on meta servers with thousands of clients

Reduced kernel/userspace context switches is 'just' a side effect.

Thanks,
Dharmendra
