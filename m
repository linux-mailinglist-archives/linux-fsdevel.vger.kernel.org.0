Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E844D6132
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 13:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348525AbiCKMGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 07:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348516AbiCKMGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:06:11 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4521B0BC0;
        Fri, 11 Mar 2022 04:05:08 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q29so6321398pgn.7;
        Fri, 11 Mar 2022 04:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CRZrxVCznRSFRiW8IRzuy7VCEoOd0f/N6kmnVLmNDCo=;
        b=PIMumTL+lPiaLTDARKWQVdKtj36k1b+cDb4eko7v9IKCgaf3im7MLOYJq4n9sVJZoC
         p9etEmA/GnBA1+zS6bTwNptNoDxQKvsHB2Icf3kGYTSZ+Jmkvo8WyXZK07iM10jR4H73
         rk6IsQCBLfPlkSf30TwmGEDbHzmkXSnwhjfYJwmvofTiqGi0UmHMWrzMyagGXQ35w5zD
         UHp2z+ahJPfNEyf6iiCaXG2iT+0V52ggpJTBfDWXWVU+5TCShdyxEZy5TZHGhlnQDgOY
         Nz/xQBCf3SqOrQtGfU+on2Ybrf8Dw6s7aILP3nBATfBTvjUkdOFQqAtlixycwshVbPwq
         1kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CRZrxVCznRSFRiW8IRzuy7VCEoOd0f/N6kmnVLmNDCo=;
        b=DEgyvlFsOWbrXSAGonpSpHber+/iFs9SziWLrbvV7uLVkT8bdszUiJSBt6kTzPjsxI
         mSGDulqejjanMs4gpW4ntHC1lgYHe0L94TOjCjEnGoVJ6uCSUzeN3k/i5E3chAgKg4Kt
         hiENJyDsq3ImH0pEPn1sF1trvJy7N0FiLTn30nzGuzCNcSO4GNQozKpc3y/f0PzUux4D
         NCff/w1KKQCCFrn2F8FlO8EvfGaf3KD4pCLDOcABLPYvnNizqT+S8I1eZpaMaqWf/aBe
         aOD8r2rJhk4Q7Hu9yydYxb8WajpQFq5/11E7vB7zQrSp/R6Hy9OuLDouXvqogvjvbfAs
         76GA==
X-Gm-Message-State: AOAM531KNzJjXp0Xh/mQtjok54LX6pq8WhM2jOVpkfmpFL8MaQhV85dV
        VUMDhSGA9dCFERtkoVASOuY=
X-Google-Smtp-Source: ABdhPJzh/eDMFQo02GzsyE2jTQcSk9b+KymAzlFOwPAbU3mmer/hQXlvh6fX1i7+fDCY0ACVm1lEBw==
X-Received: by 2002:a62:1481:0:b0:4f6:38c0:ed08 with SMTP id 123-20020a621481000000b004f638c0ed08mr10030490pfu.86.1647000307460;
        Fri, 11 Mar 2022 04:05:07 -0800 (PST)
Received: from localhost.localdomain ([219.91.230.201])
        by smtp.googlemail.com with ESMTPSA id lw18-20020a17090b181200b001bf057106ebsm13954488pjb.41.2022.03.11.04.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 04:05:07 -0800 (PST)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu
Cc:     fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, bschubert@ddn.com,
        amir73il@gmail.com, dharamhans87@gmail.com
Subject: 'Re: [PATCH 0/2] FUSE: Implement atomic lookup + open'
Date:   Fri, 11 Mar 2022 17:34:56 +0530
Message-Id: <20220311120456.18298-1-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJfpegu4L6s9vR0FUuVuHfNpBM_PJuR8XJQsQnwRVFkZD4KJEQ@mail.gmail.com>
References: <CAJfpegu4L6s9vR0FUuVuHfNpBM_PJuR8XJQsQnwRVFkZD4KJEQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
changed. In Table 0B, 3rd row we have Read perf reduced, it was found out that this was caused by some changes
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
