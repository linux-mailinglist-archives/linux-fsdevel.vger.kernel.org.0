Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E85527C30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 13:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfEWLv3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 07:51:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36530 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfEWLvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 07:51:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so8840382edx.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 04:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DxrwlFYynfpKWcnso1ASEMJy1QePVih8VzbqwCBkVwk=;
        b=S/Ixtxvc2rCTBfYbzQGiR2W1gdfRhjumXOGgdu6z5ZJn93UKfws6k6ee18PWPXzlDD
         34VNSUVl1F53yAPBVRFXImrLpe7sp1R3RWU6ueWOjvI6M8sU1iNP4im0skwaqTuQRUI3
         sJIA+/8okDM6QZIbI5rbYpsc3IcvP6Y2vT3m/sqm3D8RJWvk/pCqLrz+0Bww9JTf0nJB
         iYoTll8Maxv4hlDHAWHuPjFK29juGO9XVC/XtHjE4Ia93dBRDXi9FTYBwym4yIuDO3bU
         KpK6X02jkldIOkbi8+Z06PuUo/TGQJMyBrB/dAr/0sdCeNd8eYTqTlNcvQeNZ+q4dvvT
         hkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DxrwlFYynfpKWcnso1ASEMJy1QePVih8VzbqwCBkVwk=;
        b=s9K1h+NRg0TuXmEsVuv2eBhQZNDtKzi1hGUsMIZroH9z/HMKhapsE+ICYKMyyCy+na
         MwrVf/kqQq1qiQvHpvlZhmSit5ZIaCrptkLgkTUZyVinmxC76S/WuijsnkychicRf3B9
         KJ4ohGM8NAaoWCE/M5ZX+Pzuc4Cc0bCZ4qwugLIg2SxzEdjB1s7+qeu2IBXGA2cBH3Ab
         pUuDA9b8n7J5l8lzzI6td/x63V23kA0V8Qi6aEGFBBK8tOdLoxLFzN4uShGq+X4BiFxy
         67hkMAJij7ZUMfOCc5KACX93Nx/fxvEpxfXRO21BYWs0sv8gZdoAt5c/HG2FhIQcImzH
         pEAQ==
X-Gm-Message-State: APjAAAWg6iVgHVcgiE1pYXsqIkm5bro4NCbAvTaR3F420iulIEzTHoRh
        tObsZeeIdei6LT5hJ2aBB4ZFPw==
X-Google-Smtp-Source: APXvYqx7/y/DNnexBZOnXkDyT0N3tMuirzQAMafDXHp1AgKt73Se0dTImjP3o0mVoffNMpPelxEu9Q==
X-Received: by 2002:a50:84a1:: with SMTP id 30mr95678372edq.105.1558612282526;
        Thu, 23 May 2019 04:51:22 -0700 (PDT)
Received: from brauner.io (178-197-142-46.pool.kielnet.net. [46.142.197.178])
        by smtp.gmail.com with ESMTPSA id h23sm4406908ejc.34.2019.05.23.04.51.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 04:51:22 -0700 (PDT)
Date:   Thu, 23 May 2019 13:51:20 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, fweimer@redhat.com,
        jannh@google.com, tglx@linutronix.de, arnd@arndb.de,
        shuah@kernel.org, dhowells@redhat.com, tkjos@android.com,
        ldv@altlinux.org, miklos@szeredi.hu, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v1 1/2] open: add close_range()
Message-ID: <20190523115118.pmscbd6kaqy37dym@brauner.io>
References: <20190522155259.11174-1-christian@brauner.io>
 <20190522165737.GC4915@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522165737.GC4915@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 06:57:37PM +0200, Oleg Nesterov wrote:
> On 05/22, Christian Brauner wrote:
> >
> > +static struct file *pick_file(struct files_struct *files, unsigned fd)
> >  {
> > -	struct file *file;
> > +	struct file *file = NULL;
> >  	struct fdtable *fdt;
> >  
> >  	spin_lock(&files->file_lock);
> > @@ -632,15 +629,65 @@ int __close_fd(struct files_struct *files, unsigned fd)
> >  		goto out_unlock;
> >  	rcu_assign_pointer(fdt->fd[fd], NULL);
> >  	__put_unused_fd(files, fd);
> > -	spin_unlock(&files->file_lock);
> > -	return filp_close(file, files);
> >  
> >  out_unlock:
> >  	spin_unlock(&files->file_lock);
> > -	return -EBADF;
> > +	return file;
> 
> ...
> 
> > +int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
> > +{
> > +	unsigned int cur_max;
> > +
> > +	if (fd > max_fd)
> > +		return -EINVAL;
> > +
> > +	rcu_read_lock();
> > +	cur_max = files_fdtable(files)->max_fds;
> > +	rcu_read_unlock();
> > +
> > +	/* cap to last valid index into fdtable */
> > +	if (max_fd >= cur_max)
> > +		max_fd = cur_max - 1;
> > +
> > +	while (fd <= max_fd) {
> > +		struct file *file;
> > +
> > +		file = pick_file(files, fd++);
> 
> Well, how about something like
> 
> 	static unsigned int find_next_opened_fd(struct fdtable *fdt, unsigned start)
> 	{
> 		unsigned int maxfd = fdt->max_fds;
> 		unsigned int maxbit = maxfd / BITS_PER_LONG;
> 		unsigned int bitbit = start / BITS_PER_LONG;
> 
> 		bitbit = find_next_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
> 		if (bitbit > maxfd)
> 			return maxfd;
> 		if (bitbit > start)
> 			start = bitbit;
> 		return find_next_bit(fdt->open_fds, maxfd, start);
> 	}

> 
> 	unsigned close_next_fd(struct files_struct *files, unsigned start, unsigned maxfd)
> 	{
> 		unsigned fd;
> 		struct file *file;
> 		struct fdtable *fdt;
> 	
> 		spin_lock(&files->file_lock);
> 		fdt = files_fdtable(files);
> 		fd = find_next_opened_fd(fdt, start);
> 		if (fd >= fdt->max_fds || fd > maxfd) {
> 			fd = -1;
> 			goto out;
> 		}
> 
> 		file = fdt->fd[fd];
> 		rcu_assign_pointer(fdt->fd[fd], NULL);
> 		__put_unused_fd(files, fd);
> 	out:
> 		spin_unlock(&files->file_lock);
> 
> 		if (fd == -1u)
> 			return fd;
> 
> 		filp_close(file, files);
> 		return fd + 1;
> 	}

Thanks, Oleg!

I kept it dumb and was about to reply that your solution introduces more
code when it seemed we wanted to keep this very simple for now.
But then I saw that find_next_opened_fd() already exists as
find_next_fd(). So it's actually not bad compared to what I sent in v1.
So - with some small tweaks (need to test it and all now) - how do we
feel about?:

/**
 * __close_next_open_fd() - Close the nearest open fd.
 *
 * @curfd: lowest file descriptor to consider
 * @maxfd: highest file descriptor to consider
 *
 * This function will close the nearest open fd, i.e. it will either
 * close @curfd if it is open or the closest open file descriptor
 * c greater than @curfd that
 * is smaller or equal to maxfd.
 * If the function found a file descriptor to close it will return 0 and
 * place the file descriptor it closed in @curfd. If it did not find a
 * file descriptor to close it will return -EBADF.
 */
static int __close_next_open_fd(struct files_struct *files, unsigned *curfd, unsigned maxfd)
{
        struct file *file = NULL;
	unsigned fd;
	struct fdtable *fdt;

	spin_lock(&files->file_lock);
	fdt = files_fdtable(files);
	fd = find_next_fd(fdt, *curfd);
	if (fd >= fdt->max_fds || fd > maxfd)
		goto out_unlock;

	file = fdt->fd[fd];
	rcu_assign_pointer(fdt->fd[fd], NULL);
	__put_unused_fd(files, fd);

out_unlock:
	spin_unlock(&files->file_lock);

	if (!file)
		return -EBADF;

	*curfd = fd;
	filp_close(file, files);
	return 0;
}

int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
{
	if (fd > max_fd)
		return -EINVAL;

	while (fd <= max_fd) {
		if (__close_next_fd(files, &fd, maxfd))
			break;

		cond_resched();
		fd++;
	}

	return 0;
}

SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
		unsigned int, flags)
{
	if (flags)
		return -EINVAL;

	return __close_range(current->files, fd, max_fd);
}
