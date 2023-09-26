Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510CB7AF640
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 00:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjIZWWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 18:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjIZWT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:19:59 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242F13C1F;
        Tue, 26 Sep 2023 14:07:54 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-57b67c84999so5291987eaf.3;
        Tue, 26 Sep 2023 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695762473; x=1696367273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SNOIMtNwJVFZk1B2LMZgeRZzN7oUxPuf4PQMf6TkEfA=;
        b=VPoN5KMiCpHbnHkT2lRbU9InaA9vQIhz1MvqGNVjTUj4ixloJD9yunnPVP3S6RN5sa
         UGmpwze1BnHgLyZDKA1Dxy7YNwlbba4YqQmqC+YDbKwDNlsXnvy9oRe2k45B8dS3MBa0
         +6fY+tdSSwI/6lYWppdQvOd7XfMkZi55G1JGQ1xRJpSCsWNapOTNn7Wkkk56rA4ToZio
         LtDlSeZYtKVxmbk/sHcK9Nm1rm9j7BQ9Qd1szlI79osO1fxAv3IVwyTJPscCLEVwBujx
         2MIA0GlUBn287Lx+rLNaK8LdEQ3mJKxQNzVLkEsjDgVzyEBY45+3ooiBtWlrc3lkuYdz
         6Esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695762473; x=1696367273;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNOIMtNwJVFZk1B2LMZgeRZzN7oUxPuf4PQMf6TkEfA=;
        b=tn8Vqrh0YJQ2L7FZp1caIRyuT3SbZ42P/MyrCmADj6L5tWOgCeq+OkcSbqDZysgkL8
         McxH0DBtJw//vktFRCstT47kHXDsK7MMThYdsQ8cfJFb1J0iv5OfYWqof0KxWeio8T0c
         XZsypN/k9GhIjeiFYxvkQ8BE2sc7EjkjYsPK8FbJvpsPfGHJkna1Y/88JzAvw/oEDOrI
         IO5ffuXFRywbkOXMk74qRsFNx5VMh+0lEBh56dN8DKCAc8PNzBe/b3Kebnp2YMH0cDMx
         eXrd4pFnGK7yemTa63bG0XeQ0RrP4upo84CjmZnQuH7kT9VYDhHCp0OgQ9MfTM8zvupu
         tW7w==
X-Gm-Message-State: AOJu0YwxvxXJjz4HrMSquwbk64GoJ4d5rXv+kgC2Cfas5gJvyHLr6kmW
        QGvDfsimORbnaoNy87nIQZ32Hq83HZh02zRFnu32kbglGEw=
X-Google-Smtp-Source: AGHT+IF4uPWJOGuTdTNIjOplspR7iwiXfyCBo1ZgMZpXlL1oQ4znqNylvJzapdMpcxIaPx5NrOUWvC4PiRP3U4cF2YE=
X-Received: by 2002:a4a:6c58:0:b0:57b:6ab1:87c9 with SMTP id
 u24-20020a4a6c58000000b0057b6ab187c9mr351551oof.0.1695762473321; Tue, 26 Sep
 2023 14:07:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5d4a:0:b0:4f0:1250:dd51 with HTTP; Tue, 26 Sep 2023
 14:07:52 -0700 (PDT)
In-Reply-To: <25875.17995.247620.601505@quad.stoffel.home>
References: <20230925205545.4135472-1-mjguzik@gmail.com> <25875.17995.247620.601505@quad.stoffel.home>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 26 Sep 2023 23:07:52 +0200
Message-ID: <CAGudoHF9nrmR6eH91YpcG4795YAKxemKeMvWNSLaiWtQAYX0uA@mail.gmail.com>
Subject: Re: [PATCH] vfs: shave work on failed file open
To:     John Stoffel <john@stoffel.org>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/26/23, John Stoffel <john@stoffel.org> wrote:
>>>>>> "Mateusz" == Mateusz Guzik <mjguzik@gmail.com> writes:
>
>> Failed opens (mostly ENOENT) legitimately happen a lot, for example here
>> are stats from stracing kernel build for few seconds (strace -fc make):
>
>>   % time     seconds  usecs/call     calls    errors syscall
>>   ------ ----------- ----------- --------- --------- ------------------
>>     0.76    0.076233           5     15040      3688 openat
>
>> (this is tons of header files tried in different paths)
>
>> Apart from a rare corner case where the file object is fully constructed
>> and we need to abort, there is a lot of overhead which can be avoided.
>
>> Most notably delegation of freeing to task_work, which comes with an
>> enormous cost (see 021a160abf62 ("fs: use __fput_sync in close(2)" for
>> an example).
>
>> Benched with will-it-scale with a custom testcase based on
>> tests/open1.c:
>> [snip]
>>         while (1) {
>>                 int fd = open("/tmp/nonexistent", O_RDONLY);
>>                 assert(fd == -1);
>
>>                 (*iterations)++;
>>         }
>> [/snip]
>
>> Sapphire Rapids, one worker in single-threaded case (ops/s):
>> before:	1950013
>> after:	2914973 (+49%)
>
>
> So what are the times in a multi-threaded case?  Just wondering what
> happens if you have a bunch of makes or other jobs like that all
> running at once.
>

On my kernel they heavily bottleneck on apparmor, I already mailed the author:
https://lore.kernel.org/all/CAGudoHFfG7mARwSqcoLNwV81-KX4Bici5FQHjoNG4f9m83oLyg@mail.gmail.com/

maybe i'll hack up the fix

When running without that LSM and on *stock* kernel it heavily
bottlenecks somewhere in bowels of SLUB + RCU.

Without LSM and with the patch it scales almost perfectly, as one would expect.

I don't have numbers nor perf output handy.

>
>> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>> ---
>>  fs/file_table.c      | 39 +++++++++++++++++++++++++++++++++++++++
>>  fs/namei.c           |  2 +-
>>  include/linux/file.h |  1 +
>>  3 files changed, 41 insertions(+), 1 deletion(-)
>
>> diff --git a/fs/file_table.c b/fs/file_table.c
>> index ee21b3da9d08..320dc1f9aa0e 100644
>> --- a/fs/file_table.c
>> +++ b/fs/file_table.c
>> @@ -82,6 +82,16 @@ static inline void file_free(struct file *f)
>>  	call_rcu(&f->f_rcuhead, file_free_rcu);
>>  }
>
>> +static inline void file_free_badopen(struct file *f)
>> +{
>> +	BUG_ON(f->f_mode & (FMODE_BACKING | FMODE_OPENED));
>
> eww... what a BUG_ON() here?  This seems *way* overkill to crash the
> system here, and you don't even check if f exists first as well, since
> I assume the caller checks it or already knows it?
>
> Why not just return an error here and keep going?  What happens if you do?
>

The only caller already checked these flags, so I think BUGing out is prudent.

>
>> +	security_file_free(f);
>> +	put_cred(f->f_cred);
>> +	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
>> +		percpu_counter_dec(&nr_files);
>> +	kmem_cache_free(filp_cachep, f);
>> +}
>> +
>>  /*
>>   * Return the total number of open files in the system
>>   */
>> @@ -468,6 +478,35 @@ void __fput_sync(struct file *file)
>>  EXPORT_SYMBOL(fput);
>>  EXPORT_SYMBOL(__fput_sync);
>
>> +/*
>> + * Clean up after failing to open (e.g., open(2) returns with -ENOENT).
>> + *
>> + * This represents opportunities to shave on work in the common case
>> compared
>> + * to the usual fput:
>> + * 1. vast majority of the time FMODE_OPENED is not set, meaning there is
>> no
>> + *    need to delegate to task_work
>> + * 2. if the above holds then we are guaranteed we have the only
>> reference with
>> + *    nobody else seeing the file, thus no need to use atomics to release
>> it
>> + * 3. then there is no need to delegate freeing to RCU
>> + */
>> +void fput_badopen(struct file *file)
>> +{
>> +	if (unlikely(file->f_mode & (FMODE_BACKING | FMODE_OPENED))) {
>> +		fput(file);
>> +		return;
>> +	}
>> +
>> +	if (WARN_ON(atomic_long_read(&file->f_count) != 1)) {
>> +		fput(file);
>> +		return;
>> +	}
>> +
>> +	/* zero out the ref count to appease possible asserts */
>> +	atomic_long_set(&file->f_count, 0);
>> +	file_free_badopen(file);
>> +}
>> +EXPORT_SYMBOL(fput_badopen);
>> +
>>  void __init files_init(void)
>>  {
>>  	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 567ee547492b..67579fe30b28 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -3802,7 +3802,7 @@ static struct file *path_openat(struct nameidata
>> *nd,
>>  		WARN_ON(1);
>>  		error = -EINVAL;
>>  	}
>> -	fput(file);
>> +	fput_badopen(file);
>>  	if (error == -EOPENSTALE) {
>>  		if (flags & LOOKUP_RCU)
>>  			error = -ECHILD;
>> diff --git a/include/linux/file.h b/include/linux/file.h
>> index 6e9099d29343..96300e27d9a8 100644
>> --- a/include/linux/file.h
>> +++ b/include/linux/file.h
>> @@ -15,6 +15,7 @@
>>  struct file;
>
>>  extern void fput(struct file *);
>> +extern void fput_badopen(struct file *);
>
>>  struct file_operations;
>>  struct task_struct;
>> --
>> 2.39.2
>
>


-- 
Mateusz Guzik <mjguzik gmail.com>
