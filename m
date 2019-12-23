Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C3D1299F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 19:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLWSqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 13:46:04 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:42148 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfLWSqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 13:46:03 -0500
Received: by mail-wr1-f47.google.com with SMTP id q6so17559459wro.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2019 10:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unipv-it.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=w5CMUkOgI9O50Lpl1QlGs5TpfGYKinCiTcdt0eBfYEo=;
        b=1xfOpsDewZMEL8VURraPRYQC54Kr6g5gmBmvHkk+Wa4T+65VVoUvl5uQUYkQUlfjER
         RTOMeycBczuwQiFOj0Ndy053ltaRrVXZzEIGIJmTL0hltq3d1RAUcf46EZ0KTlVG8mRI
         oxVE2yNmnimz+Rw6yr4DtRKQtvSesKe7g8O628dbIs9zx8M6NPoZCXzYc01paKsZEcKK
         5byZFlT947iY2xIYKNNORSOlMd4y+GDvuk7gaRasO0Gyh0Qr1ZKTtDmGGoMWC5t3oziu
         gry34a4C+QIeIieVjX33VL8TUBlXws33je4Byo03PMQSLfqMB2VT0NdLTjWpWUazkg6z
         Wm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=w5CMUkOgI9O50Lpl1QlGs5TpfGYKinCiTcdt0eBfYEo=;
        b=PG+1XE8zwY/bURZBYUsdG11Yt/u8zvMZiSsFn6joYwWdwxM2TC9dwZZir8G/FPhT4y
         lxCrgbo2BHnB8tg6Nfgufwzgon8ajaEh3QNtjwb7bPzvcBx/RAz1J9qs6dZzdKRhi/Oi
         a8h/dVVTWu6h8dUgXjjnbq0prKYCnvGeYhA0SPVtOFPcZAVwAmu9PGdX5aeanUqTCSoQ
         QhHg9RKgY22fSH3MPjb82/vPONQm0iUcZPD84OY8Eeo5gcFbqo0pEiXCwPj5EjncMYhB
         bTDsfARkSUDQmySfHGkzZhFce187EvVLtFVpd+vqXxpgH7Xp1ss00rZ+LXlRxebCD91U
         09DQ==
X-Gm-Message-State: APjAAAX8BzMG/3i051juIHYv7FxZ+tHK8jVaK5GjIGVJfZw7H0ezP0HM
        0vNMJM25278gTQLyvfAf/+aQwg==
X-Google-Smtp-Source: APXvYqyNnBk0/fE1k94km79FHzdxuXoFKLWnVDf7fsGDlDpvpLkztIYGych+tWyoVBZAKZfzOmxCSQ==
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr33177089wrx.26.1577126759640;
        Mon, 23 Dec 2019 10:45:59 -0800 (PST)
Received: from angus.unipv.it (angus.unipv.it. [193.206.67.163])
        by smtp.gmail.com with ESMTPSA id k8sm21275041wrl.3.2019.12.23.10.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 10:45:58 -0800 (PST)
Message-ID: <bb5d395fe47f033be0b8ed96cbebf8867d2416c4.camel@unipv.it>
Subject: Re: AW: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
From:   Andrea Vai <andrea.vai@unipv.it>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 23 Dec 2019 19:45:57 +0100
In-Reply-To: <20191223172257.GB3282@mit.edu>
References: <20191211024137.GB61323@mit.edu>
         <20191211040058.GC6864@ming.t460p> <20191211160745.GA129186@mit.edu>
         <20191211213316.GA14983@ming.t460p>
         <f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it>
         <20191218094830.GB30602@ming.t460p>
         <b1b6a0e9d690ecd9432025acd2db4ac09f834040.camel@unipv.it>
         <20191223130828.GA25948@ming.t460p> <20191223162619.GA3282@mit.edu>
         <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
         <20191223172257.GB3282@mit.edu>
Content-Type: multipart/mixed; boundary="=-weAblMnQ5amPpzK4jcZ1"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-weAblMnQ5amPpzK4jcZ1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Il giorno lun, 23/12/2019 alle 12.22 -0500, Theodore Y. Ts'o ha
scritto:
> On Mon, Dec 23, 2019 at 05:29:27PM +0100, Andrea Vai wrote:
> > I run the cp command from a bash script, or from a bash shell. I
> don't
> > know if this answer your question, otherwise feel free to tell me
> a
> > way to find the answer to give you.
> 
> What distro are you using, and/or what package is the cp command
> coming from, and what is the package name and version?

Fedora 30

$ rpm -qf `which cp`
coreutils-8.31-6.fc30.x86_64

> 
> Also, can you remind me what the bash script is and how many files
> you are copying?

basically, it's:

  mount UUID=$uuid /mnt/pendrive
  SECONDS=0
  cp $testfile /mnt/pendrive
  umount /mnt/pendrive
  tempo=$SECONDS

and it copies one file only. Anyway, you can find the whole script
attached.


> 
> Can you change the script so that the cp command is prefixed by:
> 
> "strace -tTf -o /tmp/st "
> 
> e.g.,
> 
> 	strace -tTf -o /tmp/st cp <args>
> 
> And then send me
btw, please tell me if "me" means only you or I cc: all the
recipients, as usual

>  the /tmp/st file.  This will significantly change the
> time, so don't do this for measuring performance.  I just want to
> see
> what the /bin/cp command is *doing*.

I will do it, but I have a doubt. Since the problem doesn't happen
every time, is it useful to give you a trace of a "fast" run? And, if
it's not, I think I should measure performance with the trace command
prefix, to identify a "slow" run to report you. Does it make sense?

Thanks,
Andrea

--=-weAblMnQ5amPpzK4jcZ1
Content-Type: application/x-shellscript; name="test"
Content-Disposition: attachment; filename="test"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCnRlc3RmaWxlPS9Ob0JhY2t1cC90ZXN0ZmlsZQpsb2dmaWxlPS9ob21lL2Fu
ZHJlYS90cm91Ymxlc2hvb3RpbmcvMjAxOTA0MThfbGVudGV6emFEYXIvMjAxOTA0MThfbGVudGV6
emFEYXIudHh0Cm5Ucmllcz0kMSAjIE51bWJlciBvZiB0cmllcyB3ZSBkbwoKIyB1dWlkPSI2YTlk
M2MwNS02NzU4LTQ5YzAtYTQ2ZS02Y2UyMjE0NzhlYjMiICNPREQKIyB1dWlkPSI2OGNiYzQxMi1l
N2MzLTQwN2MtODNjMS1jNzE4NTgwZTkzMGQiICNFVkVOCiMgdXVpZD0iNTcxNjM2ODAtYWI4NS00
YzQzLWE5ZGEtODYxMzMyNjJmODE1IiAjIEVWRU4gYnRyZnMKdXVpZD0iYWE3ZWVjNTItY2I5NS00
YWIzLTg1NTctZjBjZWNiYzFjMTBmIiAjIEVWRU4geGZzCiMgdXVpZD0iY2NiN2VlNmMtY2Y4ZC00
Yjg3LWFlOWYtYTJlMTNmNWMwMGU4IiAjIFNTRAojIHV1aWQ9ImY4NzU0MWYwLWZjNzItNDU0NC05
ZjFjLWUzZWU1MjEyZGFmOSIgI0czIGJpYW5jYQoKZWNobyAiU3RhcnRpbmcgJG5UcmllcyB0cmll
cyB3aXRoOiIgfCB0ZWUgLWEgJGxvZ2ZpbGUKdW5hbWUgLWEgfCB0ZWUgLWEgJGxvZ2ZpbGUKbHMg
LWxoICR0ZXN0ZmlsZSAyPiYxIHwgdGVlIC1hICRsb2dmaWxlCmJsa2lkIDI+JjEgfCB0ZWUgLWEg
JGxvZ2ZpbGUKZWNobyAidXVpZD0kdXVpZCIKZWNobyAtbiAiY2F0IC9zeXMvYmxvY2svc2RmL3F1
ZXVlL3NjaGVkdWxlciAtLT4gIiB8IHRlZSAtYSAkbG9nZmlsZQpjYXQgL3N5cy9ibG9jay9zZGYv
cXVldWUvc2NoZWR1bGVyIDI+JjEgfCB0ZWUgLWEgJGxvZ2ZpbGUKZm9yICgoIGs9MTsgazw9JG5U
cmllczsgaysrICkpOyBkbyAKICBlY2hvIC1uICJJbml6aW86ICIgfCB0ZWUgLWEgJGxvZ2ZpbGUK
ICBkYXRlIHwgdHIgLWQgIlxuIiB8IHRlZSAtYSAkbG9nZmlsZQogIHRvdWNoIGluaXppbyAyPiYx
IHx0ZWUgLWEgJGxvZ2ZpbGUKICBtb3VudCBVVUlEPSR1dWlkIC9tbnQvcGVuZHJpdmUgMj4mMSB8
dGVlIC1hICRsb2dmaWxlCiAgU0VDT05EUz0wCiAgY3AgJHRlc3RmaWxlIC9tbnQvcGVuZHJpdmUg
Mj4mMSB8dGVlIC1hICRsb2dmaWxlCiMgIGRkIGlmPSR0ZXN0ZmlsZSBvZj0vbW50L3BlbmRyaXZl
L3Rlc3RmaWxlIGJzPTFNIG9mbGFnPWRpcmVjdAojICBkZCBpZj0kdGVzdGZpbGUgb2Y9L21udC9w
ZW5kcml2ZS90ZXN0ZmlsZSBicz0xTQogIHVtb3VudCAvbW50L3BlbmRyaXZlIDI+JjEgfHRlZSAt
YSAkbG9nZmlsZQogIHRlbXBvPSRTRUNPTkRTCiAgdG91Y2ggZmluZSAyPiYxIHx0ZWUgLWEgJGxv
Z2ZpbGUKICBlY2hvIC1uICIuLi5maW5lOiAiIHwgdGVlIC1hICRsb2dmaWxlCiAgZGF0ZSB8IHRy
IC1kICJcbiIgfCB0ZWUgLWEgJGxvZ2ZpbGUKICBlY2hvICIgLS0+IGNpIGhvIG1lc3NvICR0ZW1w
byBzZWNvbmRpISIgfCB0ZWUgLWEgJGxvZ2ZpbGUKZG9uZQo=


--=-weAblMnQ5amPpzK4jcZ1--

