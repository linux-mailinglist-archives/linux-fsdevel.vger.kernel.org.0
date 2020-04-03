Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB8EB19DB0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 18:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403930AbgDCQPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 12:15:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35805 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgDCQPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:15:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so6899821wrx.2;
        Fri, 03 Apr 2020 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=V3/txuxpeIo6b8N65adSIdkM6XcxSjQZZcbwdANjf6E=;
        b=jWfQ3UgQsQocDo8fuFQDjv9pKTtf6fZUBq0wSVMLiJX9fu5+0e4hXOuY5YzDYO8H69
         TkPatJHw7AYyOAzcurQ8ECr25QGMDSznoegpeV6XHFulUENnU9HdJKmpmVWDPaFhrrv1
         gtX+7mWWcKxQqnYss8BZQlB82lNCWsVOiJdUe98topJBuIDCZOq6/aIliC5wcUuog+ao
         Hfs2mqtOIlBatdyam2XNmzQgN8r7JWFSn8Xi7FxPMduxH/9Y18ly3hCLxBFZJVYK4jIm
         ezXHmdoll/Nok0Nf9StM3EvWWQCfiHA/w8RNeQgXAU2g7d2c2qp6xDasQ7HZ+Yjo+roX
         oAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=V3/txuxpeIo6b8N65adSIdkM6XcxSjQZZcbwdANjf6E=;
        b=ixVgErV6ecXnrpgzL1Wqw0oi1RiZ4R6Ci46Xc+t3tDEY5J+ox3RnwSL6bm13L67DSz
         DGXjbyvCco3+dIjeVpLpmDXsThFIf/0Lu0Dt2iAauxBAr/9gUc1vrcfoMzBeKJqTBOvw
         pfV4Q7U9BTRmT3ohKHR6Lz490cuPnxCTFUt4cZ3fzFOy2fwJImj49dG71xLvVM6gG3ZN
         nMD/baRWttE/jPH9KFM5zA3/pA2eePHX9NfY89NyxUSCbBOgJAhmb5t38/Sz0wIjBVMx
         0r6kKn0DQrwW64770WpEacfZ+AYx7RDv3XoabdnkpsfCU5gvC8UvWJaM7PBFO+7BF1HI
         IC/g==
X-Gm-Message-State: AGi0PuY8Wz+4zpYpi8kPzSqD40zQAz+6HSucLzXiWO0ZCKXz4Prk5jBN
        6gSPm6Hbanf7CCg3pX+1DQ==
X-Google-Smtp-Source: APiQypLwgm3J+kKcYX7zSt4edI66hbUcWheROC6iNkXtEmEdHZDiPDAPdN+i4tyg/roRHb+J0nBfgQ==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr9746606wrp.230.1585930551203;
        Fri, 03 Apr 2020 09:15:51 -0700 (PDT)
Received: from earth.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id u6sm6761276wrm.65.2020.04.03.09.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 09:15:50 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <djed@earth.lan>
Date:   Fri, 3 Apr 2020 17:15:44 +0100 (BST)
To:     Jan Kara <jack@suse.cz>
cc:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, Amir Goldstein <amir73il@gmail.com>,
        "open list:FSNOTIFY: FILESYSTEM NOTIFICATION INFRASTRUCTURE" 
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/7] fsnotify: Add missing annotation for
 fsnotify_finish_user_wait()
In-Reply-To: <20200401092433.GA19466@quack2.suse.cz>
Message-ID: <alpine.LFD.2.21.2004031710120.10601@earth.lan>
References: <0/7> <20200331204643.11262-1-jbi.octave@gmail.com> <20200331204643.11262-3-jbi.octave@gmail.com> <20200401092433.GA19466@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 1 Apr 2020, Jan Kara wrote:

> On Tue 31-03-20 21:46:38, Jules Irenge wrote:
>> Sparse reports a warning at fsnotify_finish_user_wait()
>>
>> warning: context imbalance in fsnotify_finish_user_wait()
>> 	- wrong count at exit
>>
>> The root cause is the missing annotation at fsnotify_finish_user_wait()
>> Add the missing __acquires(&fsnotify_mark_srcu) annotation.
>>
>> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
>
> OK, but then fsnotify_prepare_user_wait() needs __releases annotation as
> well if we're going to be serious about sparse warnings in this code?
>
> 								Honza
>
>> ---
>>  fs/notify/mark.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
>> index 1d96216dffd1..44fea637bb02 100644
>> --- a/fs/notify/mark.c
>> +++ b/fs/notify/mark.c
>> @@ -350,6 +350,7 @@ bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
>>  }
>>
>>  void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info)
>> +	__acquires(&fsnotify_mark_srcu)
>>  {
>>  	int type;
>>
>> --
>> 2.24.1
>>
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>

Thanks for the reply. I think adding an annotation at 
fsnotify_prepare_user_wait() will not theoretically remove the warning. 
That's the only reason why I skipped it .
Best regards,
Jules
