Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9462612926D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 08:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfLWHrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 02:47:05 -0500
Received: from smtp1-3.goneo.de ([85.220.129.32]:49335 "EHLO smtp1-3.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfLWHrF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 02:47:05 -0500
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Dec 2019 02:47:05 EST
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 9A2B323F0D5;
        Mon, 23 Dec 2019 08:37:35 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.752
X-Spam-Level: 
X-Spam-Status: No, score=-2.752 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=0.148, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Uz_X5WMlX-IY; Mon, 23 Dec 2019 08:37:34 +0100 (CET)
Received: from [192.168.1.127] (dyndsl-085-016-047-111.ewe-ip-backbone.de [85.16.47.111])
        by smtp1.goneo.de (Postfix) with ESMTPSA id 1D2C523F0C6;
        Mon, 23 Dec 2019 08:37:34 +0100 (CET)
Subject: Re: [PATCH v3] Documentation: filesystems: convert fuse to RST
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, corbet@lwn.net,
        miklos@szeredi.hu
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org
References: <20191223012248.606168-1-dwlsalmeida@gmail.com>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <91ded87c-ca70-bcf7-49fc-fa2988f4e36b@darmarit.de>
Date:   Mon, 23 Dec 2019 08:37:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191223012248.606168-1-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Daniel,

just some nits ...

Am 23.12.19 um 02:22 schrieb Daniel W. S. Almeida:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
...

> diff --git a/Documentation/filesystems/fuse.txt b/Documentation/filesystems/fuse.rst
> similarity index 79%
> rename from Documentation/filesystems/fuse.txt
> rename to Documentation/filesystems/fuse.rst
> index 13af4a49e7db..1ca3aac04606 100644
> --- a/Documentation/filesystems/fuse.txt
> +++ b/Documentation/filesystems/fuse.rst
> @@ -1,41 +1,39 @@

...

>   Filesystem type
> -~~~~~~~~~~~~~~~
> +===============
>   
>   The filesystem type given to mount(2) can be one of the following:
>   
> -'fuse'
> +    **fuse**
>   

drop empty line, use definition list[1] / you used definition list everywhere 
except here.  I guess the follwowing matches better:


``fuse``
   This is the usual way to mount a FUSE filesystem. ...

``fuseblk``
   The filesystem is block device based. ..

[1] 
https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#definition-lists

-- Markus --
