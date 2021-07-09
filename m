Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39A3C26EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 17:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhGIPhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 11:37:31 -0400
Received: from sonic309-26.consmr.mail.ne1.yahoo.com ([66.163.184.152]:46413
        "EHLO sonic309-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232447AbhGIPha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 11:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1625844886; bh=SieMPENr+iK+KcL0G0K1VanNrw7E+LW+qUB6eyubrdo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=UuX+QspsKgTMINOVauXpYiuLxilbJf32GPqpPVnR7OqR1p3SrmlqPhtqPwwDcigK80r3nYqlR1cD7Y5DDkt+rUuI6rmzrGhymE3hcpneYHawyt3ftny+vLj18NfKzfxipH+JBRCtASckJVjGLU1YOaQuhrs/alOLtkSh5vbs0le+YSBoX2eeXD7aYqaLfYI3EgCOlc5DztXLfUggLSfbDe+o+LozlXmXaa5d9THTB5mIH5lnKlfsudbm9bxmy3L9PKlyPaHqzM6mizXHeLDCqYNlWT8+y7YwzamoPF+WPw9BxxJH5vijrLRa3vJVkWMWxOAtaGODSNFr0hFs/1Rldg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1625844886; bh=mFmCAD28WeyvJQBm/mNfGv4I8WQoQthHHUy4+NATfeN=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=IRoy1m3Ty/VHzNf9JaBTP1CUZ3WmhA4A0eW/ZtTKJLz5qTHMKK4ATrk1OnvmTKn7jMJtotcGCmMjaYMXI9zANOB2/TWLCzA74vOeir/xsjSQgJT60MVhF3bzXhvI8YC4ov3YxYDVX0SB/XjechvI7OllNh52sGuf3Ri6I/N1bDxuiv/a4xqj2xDFVjFwuYDPP9PKYxJzzloycD3tE18CfK5XqwRl+xirM7Sg0GFywE620yAGknf092e3v3g+b7IllWg2lXhk72S6Hlznmj3db6sTuAsdRjtfSqMAG/FWk+5jY9SKrx2IqKO8QU4O3dxINxZ5CCodQeccJFfvy9Ea2Q==
X-YMail-OSG: rqR4j5cVM1njfSUn3IfET96wE8x7NO1OkKqbMToAtk71vKCPYA.EPNcRw8iiiCl
 t6ji2zmTRnI1Zzy0g1B0EYA.y0GpBCoGNw0mC3sF2LBxdSO2YVMIM74of01IOM1l6PRuldIhRz6Z
 hxEMZUDLyKPZ6B2K7IXDpre41wnqjRk9USdzBjrs4cXTWwebeB2yreYUx5SNWGj12nhY_fAkq98v
 yC8WbLv6fYKl1Smfa1O6Cz8LS67gMPKAlMFv.ZcypWau15JkSoUU_FRh5sVDl02WigY2BRZ6aHcl
 uYeV62zhVvjFTZOgbqzJdoKx1TiVWOiI9Oku8IzeyoK5ClFO3eAvx0wGWCn9DTcSCojPa6LnLpFM
 7P6KA_aXkhMWgaJpMuwqeq9D1V7Pi2BCIUk7P.xvAmA5kREzRHh3VvtAfo7bSg3TqlEk0Pkp7LOa
 NJFd2_dmDIl9i9YxZ.Grk4ffKCDzcxOWbwRmgwIFLjHiTiUDRgDxJQEAF2qW3YWOds6Qq3LdHOO4
 dabQiRDXg_X3sA93QLohvllEqFQh4QEahwBBSw25yZfDIS_CRq9WUs0xPl.hCYwMgBT9.OAD3w5G
 JoFxDXDR13uZZJbTbZW8Nacfxw0qubeFqRkFVHypRMPg4xc3d.zEWmE8py1UPuBJmZ8OmIJMQfCA
 6IbqrB_2jolI3RaQkswKEVUaMHfKNSzqKNPkw8eMZqjwIw_vZb2KhpSHjg.5GSabNSMz5wvhZ4Rp
 bdL_KQ1xxQ9pjQ36QV81d1sQUI15YthsGLAV8Y.6ruqlORn7GwalOhT.qF0sZFNbzzwsJshc.cwv
 _mIZ5xocWEb2Q1gNxhqGbgcZcZHNEpg1l7PdYCvzCKuFATDYmrh71iGkuGP.F5g0fLMB6A9l4uew
 1_edi__Ru9k.YGiwpSNjz_1teZ3T4Kce5a0gjfbS4JZCcuAHMd1xQCGDsG5q4rWGJfYYdFOSs4Q4
 oCOXW7tflzffurUwLzZYME2HJ1omm0gQyw9ICcukMwNdrgZ573MA155MOc35gAF88cYYWRhNx34v
 zOLuEq5BNMbEZecAyYv8Qbn8BAFLz4NOKAyuqEvtNtGdV.yMJ6w_31QMn8d_SwymZsKeX7yewydu
 xum1sOmUooix_h9PsTJ_ZKEHTxV_wAYmGXOChj4E8DAHcJLPuTMxjA0E0ehqpcmMf0s1fdoy5D06
 NJ48yenLP5ZHTwYqDbV4H7qSjyiYu4vaiZ8nO89xdhbsUJv74XhcENz5zprVAr.UDfBnEWrTT3sl
 IIwGvZcA1O9RQFwctjdtLDPTrcY0J67QQY12xHj4p1_5ks1tpE5qbCXyIv.l.J6__ExjwpGKObhK
 gvd6d0h5ebZ123NO0hOR3wWZf6_gpVbKGxdCsbnqmmajL9yJuddMhFO7iumXI6Q7N63mZnXyULs5
 cPEXA08i79juiVmd8qpGVakw36nMl1oWBb_KLJpjGLtg9sIfhtVCPcgtB95JLouX70VekTBIdFPz
 PMHsjD2.0.zXhFAIGZULKbvJhAqapgL.JW2hfGL0MyyvodcQz4W7H7Q36bDL4FPsZT88FnxI2s8i
 k9EswSlYCdl8U.ffGQATJJgioz2Tx3YLUJJs4B0vANWzJVd1fIIDrQBPCIbxn2mgiRYX23LWf77q
 I.Sh.MGjDowsq7sJy7wWtmCIZlNuvAjceSDkhnbB8mr8wcYhBYnXQ_00qNLo5oGTt0dtPa_e4H91
 8N9pVmO.5ROOx8Rz9VHUmSy2prGhr70hRoUc0jElhBovORgRkvZRiZ5HShvUyyEfMU1SGzqP3wKH
 yYdFH.UcZdus5T.B8HAWfWuhFK.yJ.GBPOjbUYlcj7Z8pWkHPX_nTCldGmOh_7AruyYjekSIQsqq
 IgVVFMP2YHVBuwIV5VG1MCfJlguWbvIb9BFZTZEYMvCj.11DPd.gkxE5ZsNwbs16FNKsrIOcxiUO
 t3SYnxyR2vpXFim5j3HU0awnSbCUdiA1Oldkj30Ikl5z0RQSQlixU1GbvxemDt76T2GnKBg4BM7s
 e3G00SyqikYLnqAekt.dhHiVqJRLPW3K7QDjjcts3uNELNqAnl.HmJ4kmxIKn0Yh9DVCBgNCxzTT
 yXD_EpKZvX9DuwiETLnzTGN11MRghma401r0xoltxeRraJGVJ4idk7s7wVZEgymaQdKrnLLyDvjp
 hhVCO36OUJcIGyH3VUSYBhfFKKGYIAAvNcRc8q49zN4dTHiO124GTEQ4NNFs1XBJ0ZgelHoGRd7V
 r.V4Ucgh9LqiiWRuUDRAwCn5vkg8BMko01pui76697VwWdNDbV_eAEMhzIgHds9cJVG875nE1.8J
 7fTync39Pg87NaIHYluXTGAzvdWm57DNv.TVq5dffVvzowkpGU8p7P6TPAhAECmnp3rIm242Ea_K
 bmzBt.FxM5strzrs3Jjqm2wrz_hE3.yY_O3sLGCA81.sB46GG5K1kJSKjaVdZm66itN3d9YBnozc
 fNV.IZ5YpeCgIyYGR_mcKhq_03oWviqFVVFthJLPT4JZ0sdmxAkgGBy.x3oNj0GGCEl6vC_XM66X
 Z0U7WpdG2UYjaZXrW4uMEZ_OAfU7eEE23wCqqzyp27M6U_G63_WQZcgR4AWzBAmyuGBy9R_DY81p
 CakJanov71_PEzfMGcv7.m7fj0F6_FBpVQWMN5pejI5H8F.szCW94.2sxb8LpRVVx2x9sXLDc4jn
 Qmv707Jx2xvBmPSTiQrFLTKxb5hFI.fTa0KdLUZHZ8CNLQpBPpj__906YkICBXQ_Kl2JlBdHchah
 2gjCRkIDSGf8j71w.TpYWowCt33edyirYmf3YCh78Aa7yoT36RudERYRU1kaxvzRzHODxgWY3h0I
 kqcagtjYrcqYmrcs90z.PatWZFYETTKjM5AWOCDFOZGLQGLRMRx2qC62sZnInMexNxeVAZrADANZ
 QxFqfGL6TqFLktItkhv9vf4Ace31bppJdcVctDwTWuj0iejysT7u9R.jGsvFcEv4JVo_LybXwyvB
 0QpBcM.PUShNdRG7mzL5VLLoMr8biFESUh75rcFw5Tx7eAq112bKkrYiKwvSzx9Sq9XxcUcmB1Df
 ysB0VkswtFyE4kXxUeExmlzSwyTtCp8Y3_GCOCwW6kX4dHR3h6j0O.d1w.lLI.dJ8uOn3_LhjBch
 4_hqiD7jAP85vXDb4f96FMvoYSh5EJmhnjX2bk4VxaWnSBstNVv.TeJSJ_UnP_7O6kHCvW2S87HX
 LvSg8XSXN36eIl7RMSbJm_NEPaGn7ppFIQX1QdPAeJFo6XhPYRl13WuYsdf4rX4gbqc4nr5o6oEQ
 ZzchkxtVPd3kqIo381wvT4r_z3IJkvLG4gCJyJu4LVucvJ.QpbfgxXc.w1pQL7UdPK6dvVZwTQte
 gwNMNJxOgtAp1IZIkMc_7pYCkgnmY6NeCvzvRqm1a4UchEySQ23ca4oKlSf9p1qL0.fQn3YRNe7u
 LWG5p0TuQF.uXzJIRTIg16JDqvnC0Wv021PaTpx8HM8Y1lLGOvWA2RRopUg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Jul 2021 15:34:46 +0000
Received: by kubenode518.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID dc43f1ea77d9eed1d0348d0ea29f1fd6;
          Fri, 09 Jul 2021 15:34:43 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special
 files
To:     Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        jack@suse.cz, Christoph Hellwig <hch@infradead.org>
References: <20210708175738.360757-1-vgoyal@redhat.com>
 <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
 <20210709152737.GA398382@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
Date:   Fri, 9 Jul 2021 08:34:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709152737.GA398382@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/9/2021 8:27 AM, Vivek Goyal wrote:
> On Fri, Jul 09, 2021 at 11:19:15AM +0200, Christian Brauner wrote:
>> On Thu, Jul 08, 2021 at 01:57:38PM -0400, Vivek Goyal wrote:
>>> Currently user.* xattr are not allowed on symlink and special files.
>>>
>>> man xattr and recent discussion suggested that primary reason for this
>>> restriction is how file permissions for symlinks and special files
>>> are little different from regular files and directories.
>>>
>>> For symlinks, they are world readable/writable and if user xattr were
>>> to be permitted, it will allow unpriviliged users to dump a huge amount
>>> of user.* xattrs on symlinks without any control.
>>>
>>> For special files, permissions typically control capability to read/write
>>> from devices (and not necessarily from filesystem). So if a user can
>>> write to device (/dev/null), does not necessarily mean it should be allowed
>>> to write large number of user.* xattrs on the filesystem device node is
>>> residing in.
>>>
>>> This patch proposes to relax the restrictions a bit and allow file owner
>>> or priviliged user (CAP_FOWNER), to be able to read/write user.* xattrs
>>> on symlink and special files.
>>>
>>> virtiofs daemon has a need to store user.* xatrrs on all the files
>>> (including symlinks and special files), and currently that fails. This
>>> patch should help.
>>>
>>> Link: https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/
>>> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>>> ---
>> Seems reasonable and useful.
>> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>>
>> One question, do all filesystem supporting xattrs deal with setting them
>> on symlinks/device files correctly?
> Wrote a simple bash script to do setfattr/getfattr user.foo xattr on
> symlink and device node on ext4, xfs and btrfs and it works fine.

How about nfs, tmpfs, overlayfs and/or some of the other less conventional
filesystems?

>
> https://github.com/rhvgoyal/misc/blob/master/generic-programs/user-xattr-special-files.sh
>
> I probably can add some more filesystems to test.
>
> Thanks
> Vivek
>
>>>  fs/xattr.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/xattr.c b/fs/xattr.c
>>> index 5c8c5175b385..2f1855c8b620 100644
>>> --- a/fs/xattr.c
>>> +++ b/fs/xattr.c
>>> @@ -120,12 +120,14 @@ xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
>>>  	}
>>>  
>>>  	/*
>>> -	 * In the user.* namespace, only regular files and directories can have
>>> -	 * extended attributes. For sticky directories, only the owner and
>>> -	 * privileged users can write attributes.
>>> +	 * In the user.* namespace, for symlinks and special files, only
>>> +	 * the owner and priviliged users can read/write attributes.
>>> +	 * For sticky directories, only the owner and privileged users can
>>> +	 * write attributes.
>>>  	 */
>>>  	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
>>> -		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
>>> +		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode) &&
>>> +		    !inode_owner_or_capable(mnt_userns, inode))
>>>  			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
>>>  		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
>>>  		    (mask & MAY_WRITE) &&
>>> -- 
>>> 2.25.4
>>>
