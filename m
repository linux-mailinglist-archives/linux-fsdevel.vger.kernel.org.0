Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E321DA50C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 00:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgESW6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 18:58:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37712 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgESW6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 18:58:40 -0400
Received: from static-50-53-45-43.bvtn.or.frontiernet.net ([50.53.45.43] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1jbBBy-00019f-Ib; Tue, 19 May 2020 22:58:34 +0000
Subject: Re: [PATCH 0/4] Relocate execve() sanity checks
To:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200518055457.12302-1-keescook@chromium.org>
 <87a724t153.fsf@x220.int.ebiederm.org> <202005190918.D2BD83F7C@keescook>
 <87o8qjstyw.fsf@x220.int.ebiederm.org> <202005191052.0A6B1D5843@keescook>
 <87sgfvrckr.fsf@x220.int.ebiederm.org> <202005191342.97EE972E3@keescook>
From:   John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUlOQkU1bXJQb0JFQURB
 azE5UHNnVmdCS2tJbW1SMmlzUFE2bzdLSmhUVEtqSmR3VmJrV1NuTm4rbzZVcDVrCm5LUDFm
 NDlFQlFsY2VXZzF5cC9Od2JSOGFkK2VTRU8vdW1hL0srUHFXdkJwdEtDOVNXRDk3Rkc0dUI0
 L2Nhb20KTEVVOTdzTFFNdG52R1dkeHJ4VlJHTTRhbnpXWU1neno1VFptSWlWVFo0M091NVZw
 YVMxVnoxWlN4UDNoL3hLTgpaci9UY1c1V1FhaTh1M1BXVm5ia2poU1pQSHYxQmdoTjY5cXhF
 UG9tckpCbTFnbXR4M1ppVm1GWGx1d1RtVGdKCk9rcEZvbDduYkowaWxuWUhyQTdTWDNDdFIx
 dXBlVXBNYS9XSWFuVk85NldkVGpISElhNDNmYmhtUXViZTR0eFMKM0ZjUUxPSlZxUXN4NmxF
 OUI3cUFwcG05aFExMHFQV3dkZlB5LyswVzZBV3ROdTVBU2lHVkNJbld6bDJIQnFZZAovWmxs
 OTN6VXErTklvQ244c0RBTTlpSCt3dGFHRGNKeXdJR0luK2VkS050SzcyQU1nQ2hUZy9qMVpv
 V0g2WmVXClBqdVVmdWJWelp0bzFGTW9HSi9TRjRNbWRRRzFpUU50ZjRzRlpiRWdYdXk5Y0dp
 MmJvbUYwenZ5QkpTQU5weGwKS05CRFlLek42S3owOUhVQWtqbEZNTmdvbUwvY2pxZ0FCdEF4
 NTlMK2RWSVpmYUYyODFwSWNVWnp3dmg1K0pvRwplT1c1dUJTTWJFN0wzOG5zem9veWtJSjVY
 ckFjaGtKeE5mejdrK0ZuUWVLRWtOekVkMkxXYzNRRjRCUVpZUlQ2ClBISGdhM1JneWtXNSsx
 d1RNcUpJTGRtdGFQYlhyRjNGdm5WMExSUGN2NHhLeDdCM2ZHbTd5Z2Rvb3dBUkFRQUIKdEIx
 S2IyaHVJRXB2YUdGdWMyVnVJRHhxYjJodVFHcHFiWGd1Ym1WMFBva0NPZ1FUQVFvQUpBSWJB
 d1VMQ1FnSApBd1VWQ2drSUN3VVdBZ01CQUFJZUFRSVhnQVVDVG8wWVZ3SVpBUUFLQ1JBRkx6
 WndHTlhEMkx4SkQvOVRKWkNwCndsbmNUZ1llcmFFTWVEZmtXdjhjMUlzTTFqMEFtRTRWdEwr
 ZkU3ODBaVlA5Z2tqZ2tkWVN4dDdlY0VUUFRLTWEKWlNpc3JsMVJ3cVUwb29nWGRYUVNweHJH
 SDAxaWN1LzJuMGpjWVNxWUtnZ1B4eTc4QkdzMkxacTRYUGZKVFptSApaR25YR3EvZURyL21T
 bmowYWF2QkptTVo2amJpUHo2eUh0QllQWjlmZG84YnRjendQNDFZZVdvSXUyNi84SUk2CmYw
 WG0zVkM1b0FhOHY3UmQrUldaYThUTXdsaHpIRXh4ZWwzanRJN0l6ek9zbm1FOS84RG0wQVJE
 NWlUTENYd1IKMWN3SS9KOUJGL1MxWHY4UE4xaHVUM0l0Q05kYXRncDh6cW9Ka2dQVmptdnlM
 NjRRM2ZFa1liZkhPV3NhYmE5LwprQVZ0Qk56OVJURmg3SUhEZkVDVmFUb3VqQmQ3QnRQcXIr
 cUlqV0ZhZEpEM0k1ZUxDVkp2VnJyb2xyQ0FUbEZ0Ck4zWWtRczZKbjFBaUlWSVUzYkhSOEdq
 ZXZnejVMbDZTQ0dIZ1Jya3lScG5TWWFVL3VMZ24zN042QVl4aS9RQUwKK2J5M0N5RUZManpX
 QUV2eVE4YnEzSXVjbjdKRWJoUy9KLy9kVXFMb2VVZjh0c0dpMDB6bXJJVFpZZUZZQVJoUQpN
 dHNmaXpJclZEdHoxaVBmL1pNcDVnUkJuaXlqcFhuMTMxY20zTTNndjZIclFzQUdubjhBSnJ1
 OEdEaTVYSllJCmNvLzEreC9xRWlOMm5DbGFBT3BiaHpOMmVVdlBEWTVXMHEzYkEvWnAybWZH
 NTJ2YlJJK3RRMEJyMUhkL3ZzbnQKVUhPOTAzbU1aZXAyTnpOM0JaNXFFdlB2RzRyVzVacTJE
 cHliV2JRclNtOW9iaUJLYjJoaGJuTmxiaUE4YW05bwpiaTVxYjJoaGJuTmxia0JqWVc1dmJt
 bGpZV3d1WTI5dFBva0NOd1FUQVFvQUlRVUNUbzBYV2dJYkF3VUxDUWdICkF3VVZDZ2tJQ3dV
 V0FnTUJBQUllQVFJWGdBQUtDUkFGTHpad0dOWEQySXRNRC85anliYzg3ZE00dUFIazZ5Tk0K
 TjBZL0JGbW10VFdWc09CaHFPbm9iNGkzOEJyRE8yQzFoUUNQQ1FlNExMczEvNHB0ZW92UXQ4
 QjJGeXJQVmp3Zwo3alpUSE5LNzRyNmxDQ1Z4eDN5dTFCN1U5UG80VlRrY3NsVmIxL3FtV3V4
 OFhXY040eXZrVHFsTCtHeHB5Sm45CjlaWmZmWEpjNk9oNlRtT2ZiS0d2TXV1djVhclNJQTNK
 SEZMZjlhTHZadEExaXNKVXI3cFM5YXBnOXVUVUdVcDcKd2ZWMFdUNlQzZUczbXRVVTJ1cDVK
 VjQ4NTBMMDVqSFM2dVdpZS9ZK3lmSk9iaXlyeE4vNlpxVzVHb25oTEJxLwptc3pjVjV2QlQz
 QkRWZTNSdkY2WGRNOU9oUG4xK1k4MXg1NCt2UTExM044aUx3RjdHR2ExNFp5SVZBTlpEMEkw
 CkhqUnZhMmsvUnFJUlR6S3l1UEg1cGtsY0tIVlBFRk1tT3pNVCtGT294Tmp2Uys3K3dHMktN
 RFlFbUhQcjFQSkIKWlNaZUh6SzE5dGZhbFBNcHBGeGkrc3lZTGFnTjBtQjdKSFF3WTdjclV1
 T0RoeWNxNjBZVnoxdGFFeWd1M1l2MgoyL0kxRUNHSHZLSEc2d2M5MG80M0MvZWxIRUNYbkVo
 N3RLcGxEY3BJQytPQ21NeEtIaFI0NitYY1p2Z3c0RGdiCjdjYTgzZVFSM0NHODlMdlFwVzJM
 TEtFRUJEajdoWmhrTGJra1BSWm0zdzhKWTQ0YXc4VnRneFdkblNFTUNMeEwKSU9OaDZ1Wjcv
 L0RZVnRjSWFNSllrZWJhWnRHZENwMElnVVpiMjQvVmR2WkNZYk82MkhrLzNWbzFuWHdIVUVz
 Mwo2RC92MWJUMFJaRmk2OUxnc0NjT2N4NGdZTGtDRFFST1pxejZBUkFBb3F3NmtrQmhXeU0x
 ZnZnYW1BVmplWjZuCktFZm5SV2JrQzk0TDFFc0pMdXAzV2IyWDBBQk5PSFNrYlNENHBBdUMy
 dEtGL0VHQnQ1Q1A3UWRWS1JHY1F6QWQKNmIyYzFJZHk5Ukx3Nnc0Z2krbm4vZDFQbTFra1lo
 a1NpNXpXYUlnMG01UlFVaytFbDh6a2Y1dGNFLzFOMFo1TwpLMkpoandGdTViWDBhMGw0Y0ZH
 V1ZRRWNpVk1ES1J0eE1qRXRrM1N4RmFsbTZaZFEycHAyODIyY2xucTR6WjltCld1MWQyd2F4
 aXorYjVJYTR3ZURZYTduNDFVUmNCRVViSkFnbmljSmtKdENUd3lJeElXMktuVnlPcmp2a1F6
 SUIKdmFQMEZkUDJ2dlpvUE1kbENJek9sSWtQTGd4RTBJV3VlVFhlQkpoTnMwMXBiOGJMcW1U
 SU1sdTRMdkJFTEEvdgplaWFqajVzOHk1NDJIL2FIc2ZCZjRNUVVoSHhPL0JaVjdoMDZLU1Vm
 SWFZN09nQWdLdUdOQjNVaWFJVVM1K2E5CmduRU9RTER4S1J5L2E3UTF2OVMrTnZ4KzdqOGlI
 M2prUUpoeFQ2WkJoWkdSeDBna0gzVCtGMG5ORG01TmFKVXMKYXN3Z0pycUZaa1VHZDJNcm0x
 cW5Ld1hpQXQ4U0ljRU5kcTMzUjBLS0tSQzgwWGd3ajhKbjMwdlhMU0crTk8xRwpIMFVNY0F4
 TXd5L3B2azZMVTVKR2paUjczSjVVTFZoSDRNTGJEZ2dEM21QYWlHOCtmb3RUckpVUHFxaGc5
 aHlVCkVQcFlHN3NxdDc0WG43OStDRVpjakxIenlsNnZBRkUyVzBreGxMdFF0VVpVSE8zNmFm
 RnY4cUdwTzNacVB2akIKVXVhdFhGNnR2VVFDd2YzSDZYTUFFUUVBQVlrQ0h3UVlBUW9BQ1FV
 Q1RtYXMrZ0liREFBS0NSQUZMelp3R05YRAoyRC9YRC8wZGRNLzRhaTFiK1RsMWp6bkthalgz
 a0crTWVFWWVJNGY0MHZjbzNyT0xyblJHRk9jYnl5ZlZGNjlNCktlcGllNE93b0kxamNUVTBB
 RGVjbmJXbkROSHByMFNjenhCTXJvM2Juckxoc212anVuVFlJdnNzQlp0QjRhVkoKanVMSUxQ
 VWxuaEZxYTdmYlZxMFpRamJpVi9ydDJqQkVOZG05cGJKWjZHam5wWUljQWJQQ0NhL2ZmTDQv
 U1FSUwpZSFhvaEdpaVM0eTVqQlRtSzVsdGZld0xPdzAyZmtleEgrSUpGcnJHQlhEU2c2bjJT
 Z3hubisrTkYzNGZYY205CnBpYXczbUtzSUNtKzBoZE5oNGFmR1o2SVdWOFBHMnRlb29WRHA0
 ZFlpaCsreFgvWFM4ekJDYzFPOXc0bnpsUDIKZ0t6bHFTV2JoaVdwaWZSSkJGYTRXdEFlSlRk
 WFlkMzdqL0JJNFJXV2hueXc3YUFQTkdqMzN5dEdITlVmNlJvMgovanRqNHRGMXkvUUZYcWpK
 Ry93R2pwZHRSZmJ0VWpxTEhJc3ZmUE5OSnEvOTU4cDc0bmRBQ2lkbFdTSHpqK09wCjI2S3Bi
 Rm5td05PMHBzaVVzbmh2SEZ3UE8vdkFibDNSc1I1KzBSbytodnMyY0VtUXV2OXIvYkRsQ2Zw
 enAydDMKY0srcmh4VXFpc094OERaZnoxQm5rYW9DUkZidnZ2ays3TC9mb21QbnRHUGtxSmNp
 WUU4VEdIa1p3MWhPa3UrNApPb00yR0I1bkVEbGorMlRGL2pMUStFaXBYOVBrUEpZdnhmUmxD
 NmRLOFBLS2ZYOUtkZm1BSWNnSGZuVjFqU24rCjh5SDJkakJQdEtpcVcwSjY5YUlzeXg3aVYv
 MDNwYVBDakpoN1hxOXZBenlkTjVVL1VBPT0KPTZQL2IKLS0tLS1FTkQgUEdQIFBVQkxJQyBL
 RVkgQkxPQ0stLS0tLQo=
Organization: Canonical
Message-ID: <4ec7af27-1614-534d-f659-b9dfe26e2f38@canonical.com>
Date:   Tue, 19 May 2020 15:58:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202005191342.97EE972E3@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/19/20 2:17 PM, Kees Cook wrote:
> On Tue, May 19, 2020 at 01:42:28PM -0500, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>>
>>> On Tue, May 19, 2020 at 12:41:27PM -0500, Eric W. Biederman wrote:
>>>> Kees Cook <keescook@chromium.org> writes:
>>>>> and given the LSM hooks, I think the noexec check is too late as well.
>>>>> (This is especially true for the coming O_MAYEXEC series, which will
>>>>> absolutely need those tests earlier as well[1] -- the permission checking
>>>>> is then in the correct place: during open, not exec.) I think the only
>>>>> question is about leaving the redundant checks in fs/exec.c, which I
>>>>> think are a cheap way to retain a sense of robustness.
>>>>
>>>> The trouble is when someone passes through changes one of the permission
>>>> checks for whatever reason (misses that they are duplicated in another
>>>> location) and things then fail in some very unexpected way.
>>>
>>> Do you think this series should drop the "late" checks in fs/exec.c?
>>> Honestly, the largest motivation for me to move the checks earlier as
>>> I've done is so that other things besides execve() can use FMODE_EXEC
>>> during open() and receive the same sanity-checking as execve() (i.e the
>>> O_MAYEXEC series -- the details are still under discussion but this
>>> cleanup will be needed regardless).
>>
>> I think this series should drop the "late" checks in fs/exec.c  It feels
>> less error prone, and it feels like that would transform this into
>> something Linus would be eager to merge because series becomes a cleanup
>> that reduces line count.
> 
> Yeah, that was my initial sense too. I just started to get nervous about
> removing the long-standing exec sanity checks. ;)
> 
>> I haven't been inside of open recently enough to remember if the
>> location you are putting the check fundamentally makes sense.  But the
>> O_MAYEXEC bits make a pretty strong case that something of the sort
>> needs to happen.
> 
> Right. I *think* it's correct place for now, based on my understanding
> of the call graph (which is why I included it in the commit logs).
> 
>> I took a quick look but I can not see clearly where path_noexec
>> and the regular file tests should go.
>>
>> I do see that you have code duplication with faccessat which suggests
>> that you haven't put the checks in the right place.
> 
> Yeah, I have notes on the similar call sites (which I concluded, perhaps
> wrongly) to ignore:
> 
> do_faccessat()
>     user_path_at(dfd, filename, lookup_flags, &path);
>     if (acc_mode & MAY_EXEC .... path_noexec()
>     inode_permission(inode, mode | MAY_ACCESS);
> 
> This appears to be strictly advisory, and the path_noexec() test is
> there to, perhaps, avoid surprises when doing access() then fexecve()?
> I would note, however, that that path-based LSMs appear to have no hook
> in this call graph at all. I was expecting a call like:
> 
> 	security_file_permission(..., mode | MAY_ACCESS)
> 
> but I couldn't find one (or anything like it), so only
> inode_permission() is being tested (which means also the existing
> execve() late tests are missed, and the newly added S_ISREG() test from
> do_dentry_open() is missed).
> 
> 

sadly correct, its something that we intend to fix but haven't gotten
to it

> prctl_set_mm_exe_file()
>     err = -EACCESS;
>     if (!S_ISREG(inode->i_mode) || path_noexec(&exe.file->f_path))
>         goto exit;
>     err = inode_permission(inode, MAY_EXEC);
> 
> This is similar (no path-based LSM hooks present, only inode_permission()
> used for permission checking), but it is at least gated by CAP_SYS_ADMIN.
> 

dito here

> 
> And this bring me to a related question from my review: does
> dentry_open() intentionally bypass security_inode_permission()? I.e. it
> calls vfs_open() not do_open():
> 
> openat2(dfd, char * filename, open_how)
>     build_open_flags(open_how, open_flags)
>     do_filp_open(dfd, filename, open_flags)
>         path_openat(nameidata, open_flags, flags)
>             file = alloc_empty_file(open_flags, current_cred());
>             do_open(nameidata, file, open_flags)
>                 may_open(path, acc_mode, open_flag)
>                     inode_permission(inode, MAY_OPEN | acc_mode)
>                         security_inode_permission(inode, acc_mode)
>                 vfs_open(path, file)
>                     do_dentry_open(file, path->dentry->d_inode, open)
>                         if (unlikely(f->f_flags & FMODE_EXEC && !S_ISREG(inode->i_mode))) ...
>                         security_file_open(f)
>                                 /* path-based LSMs check for open here
> 				 * and use FMODE_* flags to determine how a file
>                                  * is being opened. */
>                         open()
> 
> vs
> 
> dentry_open(path, flags, cred)
>         f = alloc_empty_file(flags, cred);
>         vfs_open(path, f);
> 
> I would expect dentry_open() to mostly duplicate a bunch of
> path_openat(), but it lacks the may_open() call, etc.
> 
> I really got the feeling that there was some new conceptual split needed
> inside do_open() where the nameidata details have been finished, after
> we've gained the "file" information, but before we've lost the "path"
> information. For example, may_open(path, ...) has no sense of "file",
> though it does do the inode_permission() call.
> 
yes that would be nice, sadly the path hooks are really a bolted on after thought

> Note also that may_open() is used in do_tmpfile() too, and has a comment
> implying it needs to be checking only a subset of the path details. So
> I'm not sure how to split things up.
> 
/me neither anymore

> So, that's why I put the new checks just before the may_open() call in
> do_open(): it's the most central, positions itself correctly for dealing
> with O_MAYEXEC, and doesn't appear to make any existing paths worse.
> 
>> I am wondering if we need something distinct to request the type of the
>> file being opened versus execute permissions.
> 
> Well, this is why I wanted to centralize it -- the knowledge of how a
> file is going to be used needs to be tested both by the core VFS
> (S_ISREG, path_noexec) and the LSMs. Things were inconsistent before.
> 

yep

>> All I know is being careful and putting the tests in a good logical
>> place makes the code more maintainable, whereas not being careful
>> results in all kinds of sharp corners that might be exploitable.
>> So I think it is worth digging in and figuring out where those checks
>> should live.  Especially so that code like faccessat does not need
>> to duplicate them.
> 
> I think this is the right place with respect to execve(), though I think
> there are other cases that could use to be improved (or at least made
> more consistent).
> 
> -Kees
> 

