Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8048FA20
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 02:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiAPBUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jan 2022 20:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiAPBUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jan 2022 20:20:18 -0500
Received: from mail-ua1-x964.google.com (mail-ua1-x964.google.com [IPv6:2607:f8b0:4864:20::964])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2920C061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jan 2022 17:20:17 -0800 (PST)
Received: by mail-ua1-x964.google.com with SMTP id i5so23806170uaq.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jan 2022 17:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:date:from:to:cc:subject
         :message-id:references:content-disposition:in-reply-to:user-agent;
        bh=7TggCGT3Y7PFPqkT2Odgl4NTEu/uvHlugVrvC0L80bg=;
        b=nqzrDbvC7LZjN0m+QQzg3/e80ypE80KhfS3uzNFRlF1k7YI5/DwVg+GfjLFXnKZThn
         eA0f7obvQDpZXcbtZN++WE1dVi2mNoz8JxiDPIU+A8V1plJ8/6Bkf0PUpswykIijbiPO
         /sRPeeQKj90ybtVucCYIpX2z1Bk+sY8cnAmlIgWG+ryDYntm4juvkFV7PuMChqGRvWI1
         zppo4RFy/OUoLKt6XowgppkcTzqfv8s/L10Qr/Nh1b5zIL5zqbSvVJk0Ru2OpNVFWHm+
         nsFEJ2ciA9OKwDR2fH50PMwXY1LILyRcVI01/PRUGvNm1drC6MsGR5B1Qp1DCXsiHHsO
         geaA==
X-Gm-Message-State: AOAM531WTmQQ7xk1RMmbKOB4LA0fqMGp9hrkSSW3iqJObdgTl69aJeYn
        9HR4Fw+L/jd5ahBYzjfkvC35N/NLqMQj0HiM2xKiXSeA7Vjn
X-Google-Smtp-Source: ABdhPJxXQ5Nu2QgaRhHE92szOhbDNKNd1ARWCr1DWzVj0OdL/fXXfZt89g2MtrmEjF42zbfI0Ir69lNjmhWj
X-Received: by 2002:ab0:6f04:: with SMTP id r4mr2606887uah.74.1642296016558;
        Sat, 15 Jan 2022 17:20:16 -0800 (PST)
Received: from smtp.aristanetworks.com (mx.aristanetworks.com. [162.210.129.12])
        by smtp-relay.gmail.com with ESMTPS id o17sm3412904uat.2.2022.01.15.17.20.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jan 2022 17:20:16 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from visor (unknown [10.95.68.127])
        by smtp.aristanetworks.com (Postfix) with ESMTPS id 80F3F400D65;
        Sat, 15 Jan 2022 17:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1642296015;
        bh=7TggCGT3Y7PFPqkT2Odgl4NTEu/uvHlugVrvC0L80bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0jhZWPZSkT/THu460uDVzHQ8fqy2mCwxPczkj6LoHHSzvn1zii7S3bmHIm1OwIh2o
         AjjYt7b34u0GDvHzsN2rasBscaJejvjSI5E7V3RHrZOIp7reLQ/ivWggnpJXITq+CZ
         o9cmwFIoeA3YzprZLbSPOhutqH19VVV6aLpIjwe5Q7991NDGmAIFngxVcJnaqgwrxI
         1BK3Cb2O/wmW6orH/vQCXu/w9mjFMBZ3hBFnILX4W+lskea4pr+MZNDMEZaGiuLeW7
         udRpRfopP0SoVdW/vYDAGNcBdqzzpTg96QUDk+sJwp9YvHmCZCpJ0Oy+HeNZ9BQkbY
         VSqiPBdLdg5Jg==
Date:   Sat, 15 Jan 2022 17:20:14 -0800
From:   Ivan Delalande <colona@arista.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: Potential regression after fsnotify_nameremove() rework in 5.3
Message-ID: <YeNyzoDM5hP5LtGW@visor>
References: <YeI7duagtzCtKMbM@visor>
 <CAOQ4uxjiFewan=kxBKRHr0FOmN2AJ-WKH3DT2-7kzMoBMNVWJA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjiFewan=kxBKRHr0FOmN2AJ-WKH3DT2-7kzMoBMNVWJA@mail.gmail.com>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 15, 2022 at 09:50:20PM +0200, Amir Goldstein wrote:
> On Sat, Jan 15, 2022 at 5:11 AM Ivan Delalande <colona@arista.com> wrote:
>> Sorry to bring this up so late but we might have found a regression
>> introduced by your "Sort out fsnotify_nameremove() mess" patch series
>> merged in 5.3 (116b9731ad76..7377f5bec133), and that can still be
>> reproduced on v5.16.
>>
>> Some of our processes use inotify to watch for IN_DELETE events (for
>> files on tmpfs mostly), and relied on the fact that once such events are
>> received, the files they refer to have actually been unlinked and can't
>> be open/read. So if and once open() succeeds then it is a new version of
>> the file that has been recreated with new content.
>>
>> This was true and working reliably before 5.3, but changed after
>> 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of
>> d_delete()") specifically. There is now a time window where a process
>> receiving one of those IN_DELETE events may still be able to open the
>> file and read its old content before it's really unlinked from the FS.
> 
> This is a bit surprising to me.
> Do you have a reproducer?

Yeah, I was using the following one to bisect this. It will print a
message every time it succeeds to read the file after receiving a
IN_DELETE event when run with something like `mkdir /tmp/foo;
./indelchurn /tmp/foo`. It seems to hit pretty frequently and reliably
on various systems after 5.3, even for different #define-parameters.

>> I'm not very familiar with the VFS and fsnotify internals, would you
>> consider this a regression, or was there never any intentional guarantee
>> for that behavior and it's best we work around this change in userspace?
> 
> It may be a regression if applications depend on behavior that changed,
> but if are open for changes in your application please describe in more details
> what it tries to accomplish using IN_DELETE and the ekernel your application
> is running on and then I may be able to recommend a more reliable method.

I can discuss it with our team and get more details on this but it may
be pretty complicated and costly to change. My understanding is that
these watched files are used as ID/version references for in-memory
objects shared between multiple processes to synchronize state, and
resynchronize when there are crashes or restarts. So they can be
recreated in place with the same or a different content, and so their
inode number or mtime etc. may not be useable as additonnal check.

I think we can also have a very large number of these objects and files
on some configurations, so waiting to see if we have a following
IN_CREATE, or adding more checks/synchronization logic will probably
have a significant impact at scale.

And we're targeting 5.10 and building it with our own config.

Thanks for your help and insight on this,

-- 
Ivan Delalande
Arista Networks

# ------------------------ >8 ------------------------

#include <fcntl.h>
#include <poll.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/inotify.h>
#include <sys/wait.h>
#include <unistd.h>

#define CHURN_FILES 9999
#define CHURN_SLEEP 2
#define BATCH_UNLINK 0
#define EVENTS_BUF 32

void churn(char* base)
{
	static size_t iter = 0;
	char path[128];
	int ret;

	for (int i = 0; i <= CHURN_FILES; ++i) {
		snprintf(path, sizeof(path), "%s/%d", base, i);
		FILE* f = fopen(path, "w");
		if (!f)
			exit(1);
		ret = fprintf(f, "content, iter %lu\n", iter);
		if (ret < 16)
			exit(1);
		fclose(f);
#if BATCH_UNLINK
	}
	for (int i = 0; i <= CHURN_FILES; ++i) {
		snprintf(path, sizeof(path), "%s/%d", base, i);
#endif
		ret = unlink(path);
		if (ret < 0)
			exit(1);
	}
	++iter;
}

int main(int argc, char* argv[])
{
	char events_buf[EVENTS_BUF * sizeof(struct inotify_event)];
	struct pollfd pfd = { .events = POLLIN };
	const struct inotify_event *event;
	char path[128];
	char buf[128];
	int ret;

	if (argc != 2 || access(argv[1], R_OK|W_OK)) {
		printf("%s TESTDIR\n", argv[0]);
		exit(1);
	}

	int pid = fork();
	if (pid == 0) {
		while (1) {
			churn(argv[1]);
			sleep(CHURN_SLEEP);
		}
		return 0;
	}
	else if (pid < 0)
		exit(1);

	pfd.fd = inotify_init();
	if (pfd.fd < 0)
		goto out;
	ret = inotify_add_watch(pfd.fd, argv[1], IN_DELETE);
	if (ret < 0)
		goto out;

	while (1) {
		ret = poll(&pfd, 1, -1);
		if (ret < 0)
			goto out;
		if (!(pfd.revents & POLLIN))
			continue;

		ssize_t len = read(pfd.fd, events_buf, sizeof(events_buf));
		if (len < 0)
			goto out;
		for (char *ptr = events_buf; ptr < events_buf + len;
		     ptr += sizeof(struct inotify_event) + event->len) {
			event = (const struct inotify_event *)ptr;
			if (!(event->mask & IN_DELETE))
				continue;
			snprintf(path, sizeof(path), "%s/%s", argv[1],
				 event->name);
			int f = open(path, O_RDONLY);
			if (f < 0)
				continue;
			ret = read(f, buf, sizeof(buf));
			if (ret >= 0)
				printf("Read %d from %.*s: %.*s", ret,
				       sizeof(path), path, ret, buf);
			close(f);
		}
	}

out:
	kill(pid, SIGTERM);
	wait(NULL);
	return 0;
}
