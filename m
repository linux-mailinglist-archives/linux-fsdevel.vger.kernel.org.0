Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF9D42955A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 19:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhJKRQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 13:16:32 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:42950 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232866AbhJKRQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:16:31 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D39D042C;
        Mon, 11 Oct 2021 20:14:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633972468;
        bh=hP5CrubvbNrj+5YR8Nrl4oDNVEbRN1HW7A+zrUZo4Y4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=iuBdZVohhoTEp9GoRZx2k6k3ACoHG7Fbgjsyoj6GLj34YfKvXuAOYN6gDZ96jz38V
         k92DCP+sBQJJPZ0m0dYehjZvCKicpX8FJ79FE0qlQ9qVxvjhje8kwRewpkS64SSha4
         Njbg2YP1+wQBXos2bMEJ39cKoS4U8PDiuvNLovag=
Received: from [192.168.211.33] (192.168.211.33) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 11 Oct 2021 20:14:28 +0300
Message-ID: <204a5be9-f0a2-1c85-d3a8-3011578b9299@paragon-software.com>
Date:   Mon, 11 Oct 2021 20:14:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v4 7/9] fs/ntfs3: Add iocharset= mount option as alias for
 nls=
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
CC:     <ntfs3@lists.linux.dev>, Christoph Hellwig <hch@lst.de>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        <torvalds@linux-foundation.org>
References: <20210907153557.144391-1-kari.argillander@gmail.com>
 <20210907153557.144391-8-kari.argillander@gmail.com>
 <20210908190938.l32kihefvtfw5tjp@pali> <20211009114252.jn2uehmaveucimp5@pali>
 <20211009143327.mqwwwlc4bgwtpush@kari-VirtualBox>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20211009143327.mqwwwlc4bgwtpush@kari-VirtualBox>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.33]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 09.10.2021 17:33, Kari Argillander wrote:
> Choose to add Linus to CC so that he also knows whats coming.
> 
> On Sat, Oct 09, 2021 at 01:42:52PM +0200, Pali Rohár wrote:
>> Hello!
>>
>> This patch have not been applied yet:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ntfs3/super.c#n247
>>
>> What happened that in upstream tree is still only nls= option and not
>> this iocharset=?
> 
> Very valid question. For some reason Konstantin has not sended pr to
> Linus. I have also address my concern that pr is not yet sended and he
> will make very massive "patch dumb" to rc6/rc7. See thread [1]. There is
> about 50-70 patch already which he will send to rc6/rc7. I have get also
> impression that patches which are not yet even applied to ntfs3 tree [2]
> will be also sended to rc6/rc7. There is lot of refactoring and new
> algorithms which imo are not rc material. I have sended many message to
> Konstantin about this topic, but basically ignored.
> 
> Basically we do not have anything for next merge window and every patch
> will be sended for 5.15.
> 
> [1] lore.kernel.org/lkml/20210925082823.fo2wm62xlcexhwvi@kari-VirtualBox
> [2] https://github.com/Paragon-Software-Group/linux-ntfs3/commits/master
> 
>   Argillander
> 

Hello.

I was planning to send pull request on Friday 08.10.
But there is still one panic, that wasn't resolved [1].
It seems to be tricky, so I'll be content even with quick band-aid [2].
After confirming, that it works, I plan on sending pull request.
I don't want for this panic to remain in 5.15.

[1]: https://lore.kernel.org/ntfs3/f9de5807-2311-7374-afb0-bc5dffb522c0@gmail.com/
[2]: https://lore.kernel.org/ntfs3/7e5b8dc9-9989-0e8a-9e8d-ae26b6e74df4@paragon-software.com/

>>
>> On Wednesday 08 September 2021 21:09:38 Pali Rohár wrote:
>>> On Tuesday 07 September 2021 18:35:55 Kari Argillander wrote:
>>>> Other fs drivers are using iocharset= mount option for specifying charset.
>>>> So add it also for ntfs3 and mark old nls= mount option as deprecated.
>>>>
>>>> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
>>>
>>> Reviewed-by: Pali Rohár <pali@kernel.org>
>>>
>>>> ---
>>>>  Documentation/filesystems/ntfs3.rst |  4 ++--
>>>>  fs/ntfs3/super.c                    | 18 +++++++++++-------
>>>>  2 files changed, 13 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
>>>> index af7158de6fde..ded706474825 100644
>>>> --- a/Documentation/filesystems/ntfs3.rst
>>>> +++ b/Documentation/filesystems/ntfs3.rst
>>>> @@ -32,12 +32,12 @@ generic ones.
>>>>  
>>>>  ===============================================================================
>>>>  
>>>> -nls=name		This option informs the driver how to interpret path
>>>> +iocharset=name		This option informs the driver how to interpret path
>>>>  			strings and translate them to Unicode and back. If
>>>>  			this option is not set, the default codepage will be
>>>>  			used (CONFIG_NLS_DEFAULT).
>>>>  			Examples:
>>>> -				'nls=utf8'
>>>> +				'iocharset=utf8'
>>>>  
>>>>  uid=
>>>>  gid=
>>>> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
>>>> index 729ead6f2fac..503e2e23f711 100644
>>>> --- a/fs/ntfs3/super.c
>>>> +++ b/fs/ntfs3/super.c
>>>> @@ -226,7 +226,7 @@ enum Opt {
>>>>  	Opt_nohidden,
>>>>  	Opt_showmeta,
>>>>  	Opt_acl,
>>>> -	Opt_nls,
>>>> +	Opt_iocharset,
>>>>  	Opt_prealloc,
>>>>  	Opt_no_acs_rules,
>>>>  	Opt_err,
>>>> @@ -245,9 +245,13 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
>>>>  	fsparam_flag_no("hidden",		Opt_nohidden),
>>>>  	fsparam_flag_no("acl",			Opt_acl),
>>>>  	fsparam_flag_no("showmeta",		Opt_showmeta),
>>>> -	fsparam_string("nls",			Opt_nls),
>>>>  	fsparam_flag_no("prealloc",		Opt_prealloc),
>>>>  	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
>>>> +	fsparam_string("iocharset",		Opt_iocharset),
>>>> +
>>>> +	__fsparam(fs_param_is_string,
>>>> +		  "nls", Opt_iocharset,
>>>> +		  fs_param_deprecated, NULL),
>>>>  	{}
>>>>  };
>>>>  
>>>> @@ -346,7 +350,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
>>>>  	case Opt_showmeta:
>>>>  		opts->showmeta = result.negated ? 0 : 1;
>>>>  		break;
>>>> -	case Opt_nls:
>>>> +	case Opt_iocharset:
>>>>  		kfree(opts->nls_name);
>>>>  		opts->nls_name = param->string;
>>>>  		param->string = NULL;
>>>> @@ -380,11 +384,11 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
>>>>  	new_opts->nls = ntfs_load_nls(new_opts->nls_name);
>>>>  	if (IS_ERR(new_opts->nls)) {
>>>>  		new_opts->nls = NULL;
>>>> -		errorf(fc, "ntfs3: Cannot load nls %s", new_opts->nls_name);
>>>> +		errorf(fc, "ntfs3: Cannot load iocharset %s", new_opts->nls_name);
>>>>  		return -EINVAL;
>>>>  	}
>>>>  	if (new_opts->nls != sbi->options->nls)
>>>> -		return invalf(fc, "ntfs3: Cannot use different nls when remounting!");
>>>> +		return invalf(fc, "ntfs3: Cannot use different iocharset when remounting!");
>>>>  
>>>>  	sync_filesystem(sb);
>>>>  
>>>> @@ -528,9 +532,9 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
>>>>  	if (opts->dmask)
>>>>  		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
>>>>  	if (opts->nls)
>>>> -		seq_printf(m, ",nls=%s", opts->nls->charset);
>>>> +		seq_printf(m, ",iocharset=%s", opts->nls->charset);
>>>>  	else
>>>> -		seq_puts(m, ",nls=utf8");
>>>> +		seq_puts(m, ",iocharset=utf8");
>>>>  	if (opts->sys_immutable)
>>>>  		seq_puts(m, ",sys_immutable");
>>>>  	if (opts->discard)
>>>> -- 
>>>> 2.25.1
>>>>
