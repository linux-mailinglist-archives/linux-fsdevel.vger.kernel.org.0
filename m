Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303982CF130
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 16:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgLDPtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 10:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbgLDPtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:49:42 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0DCC08E85E
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Dec 2020 07:48:56 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id p12so2932226qvj.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Dec 2020 07:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PA56DtQ3U6OS3ADt3JtiQH9iJ5okRT03tMtGP16RXIA=;
        b=p4AZo33WMTXTpz74XuTaQCvr8JjiLn7ypdk62+VPzm5BdMKt9igpjZmiV4Ts4qi6+J
         SKGTsVwNJHxvNy9D43S5RpkEjJtwvyjUcFbtGl6g7qLXlUFpBTsSCxXpBePSHE5OPbfm
         mksQaolb9sXzm7+22TDrXsouNjPDrgzfQk55cGZ8dcksUDtecVBuIrV/rL0rDS4FIXGa
         CvPH8RXGjKym1lMM679nc6sYC/ea1CzYYsrPdIStasXpT1d5deVX/6/ey0wtHLMxDXaU
         REoOC8e2HrqtsbjM8fzvA/EMqQSINaRo0nL6ofS1dQc6bP4Jew/L1eiqWwgkD+J/NGRS
         Uo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PA56DtQ3U6OS3ADt3JtiQH9iJ5okRT03tMtGP16RXIA=;
        b=N4M+cMlVNWptLefSJZECHH2GtpyWSJXOCi0Ie1w53kchQWc/HVmSCXRnhumfLXNUyv
         aFZjuBTggvkSeCUN2s2n9qY8+nR6uDo+CRJ88B9u/9CTWBwwzjPnBWhrAhFvvQxInPD3
         KxlS4kt4xMW3lMyKrktOfsPSQGWI0iuaZ9ZPd07GCAueUBD660LSxRzepQWy1kHeaxgQ
         KOx1Yyn8V8VT4ceUf+REZxuf7QIz5OCuUKAnX65jI+1eID6C8HuWgGnYPbRXTwA3JZak
         ngJo9I9do3xcC4tlIRTOTac/pQWUgszEn0hotn983zdDbQBFU3ag84n8PpqzHE9m054W
         ueTA==
X-Gm-Message-State: AOAM533xVB8C3FnrPn2EgsX7B9TV36htlo8X//LWtaJVaj7z+70p+K2A
        Nny68B+tQZyg2PXl1zJPcEdwe/SwFCsPvZdh
X-Google-Smtp-Source: ABdhPJxnvGuh1h4AicIp2Z2Ob074CL8yAHW4/pb+/Ip6VIx5jqWNzkUvWI0x5L/Pf3ERPP+MY/J4+Q==
X-Received: by 2002:a0c:e18f:: with SMTP id p15mr6149469qvl.12.1607096935114;
        Fri, 04 Dec 2020 07:48:55 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y1sm5586436qky.63.2020.12.04.07.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 07:48:54 -0800 (PST)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvme@vger.kernel.org" <linux-nvme@vger.kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Subject: [LSFMMBPF 2021] A status update
Message-ID: <fd5264ac-c84d-e1d4-01e2-62b9c05af892@toxicpanda.com>
Date:   Fri, 4 Dec 2020 10:48:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

We on the program committee hope everybody has been able to stay safe and 
healthy during this challenging time, and look forward to being able to see all 
of you in person again when it is safe.

The current plans for LSFMMBPF 2021 are to schedule an in person conference in 
H2 (after June) of 2021.  The tentative plan is to use the same hotel that we 
had planned to use for 2020, as we still have contracts with them.  However 
clearly that is not set in stone.  The Linux Foundation has done a wonderful job 
of working with us to formulate a plan and figure out the logistics that will 
work the best for everybody, I really can't thank them enough for their help.

Once we have a finalized date we will redo the CFP emails, probably coming out 
March time frame.  If you have any questions or concerns please feel free to 
respond to this email, or email me or any of the other PC members privately and 
we will do our best to answer your questions.  Rest assured the general timing 
of the conference is going to take into account the wide variety of schedules 
that we are dealing with, and we will do our best to come up with something that 
works for as many as people as possible.

We hope that you and your families continue to stay safe and health.  Thank you 
on behalf of the program committee:

	Josef Bacik (Filesystems)
	Amir Goldstein (Filesystems)
	Martin K. Petersen (Storage)
	Omar Sandoval (Storage)
	Michal Hocko (MM)
	Dan Williams (MM)
	Alexei Starovoitov (BPF)
	Daniel Borkmann (BPF)
