Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4598C2BABA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 15:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKTOGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 09:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKTOGQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:06:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03BFC0613CF;
        Fri, 20 Nov 2020 06:06:15 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s8so10117745wrw.10;
        Fri, 20 Nov 2020 06:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OgnVu/Ra7itVPrUa7jDHDw1p5InmqAllPRDiJlpQSiI=;
        b=eRdOFDh+WozCOJ0lfV0F4fCiqt+eHJi06PO4OSa0RHsgfZNasRMs5X5EyohAOo4DRc
         DTdIfhXG8bq2RHKic/C+wt4sDfxuEEg8xl2j4uQzKeFtqjXfszrz5kHbWcinemMbyT/f
         jvlvRMkVr6GQk3jvOw5zWRGsJLd+PppMqDAh1z0QZxCs1zJ5yCBOCBLCvAYRZxe2sL+k
         fQlOXcMGJt2xWrwgEpGM/HI8mcyqHBWtxodaUi7Av/kGNW2LVcMwrGguFdutMhCSIF/y
         zoyPO4wP/fTmZ6QuqO/SlhCDISdcdM50sgAh2R2ca79gmDl+JeIu/rvib0CEoyaWY086
         GNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OgnVu/Ra7itVPrUa7jDHDw1p5InmqAllPRDiJlpQSiI=;
        b=fCHwYlCq69RPWfakWXtwgrJ3Y8qji71vM1Vq3BcXVxn4BD52dMDlv+6LnyQ5ye8P1q
         aM5NM8htOaiabWoAmM2dVzkKqvG5ZAPz5ybcsPZNXDwIy2yZhT1YmPTSA4AjPCzJ9Ngw
         rToDF3Dslhe2yq3XV4BfbDCRGYfwtDuxhNt1880xS5SKrty/9cE/DnE9XDaDzqT5BsSz
         XIczF94OFUiVY+iI6TYWB6l0AauSyXO5TRj9vAGFQtj43lKopl7uY6PQwsDxltI3DCM9
         QxbdhdTp8Z4zS9D7wY+ipbWnBnP+HXicgJ/vqOXaoDKtY74q0i1tN5PC125nUXeOtkPl
         +jwA==
X-Gm-Message-State: AOAM533hMSPOszPdnlxGhg3/mmAldXneD+MTgFb0bTwxq+bpIPAkXQum
        GcYaui99iKEe8Znc4f4u+lh6LqiV4nS7ZA==
X-Google-Smtp-Source: ABdhPJxq9V5Us+H9K4wkiey86PUVRMoj27Izn57gOfIAAVF42gZxKXnA+2+aJEqfb21dviGQbL7fUA==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr15789373wrj.162.1605881172869;
        Fri, 20 Nov 2020 06:06:12 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id u5sm5104343wro.56.2020.11.20.06.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 06:06:12 -0800 (PST)
Subject: Re: [PATCH man-pages v6] Document encoded I/O
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
To:     Omar Sandoval <osandov@osandov.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, linux-man <linux-man@vger.kernel.org>
References: <cover.1605723568.git.osandov@fb.com>
 <ec1588a618bd313e5a7c05a7f4954cc2b76ddac3.1605724767.git.osandov@osandov.com>
 <4d1430aa-a374-7565-4009-7ec5139bf311@gmail.com>
Message-ID: <fb4a4270-eb7a-06d5-e703-9ee470b61f8b@gmail.com>
Date:   Fri, 20 Nov 2020 15:06:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4d1430aa-a374-7565-4009-7ec5139bf311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Omar and Michael,

please, see below.

Thanks,

Alex

On 11/20/20 12:29 AM, Alejandro Colomar (mailing lists; readonly) wrote:
> Hi Omar,
> 
> Please, see some fixes below:
> 
> Michael, I've also some questions for you below
> (you can grep for mtk to find those).
> 
> Thanks,
> 
> Alex
> 
> On 11/18/20 8:18 PM, Omar Sandoval wrote:
>> From: Omar Sandoval <osandov@fb.com>
>>
>> This adds a new page, encoded_io(7), providing an overview of encoded
>> I/O and updates fcntl(2), open(2), and preadv2(2)/pwritev2(2) to
>> reference it.
>>
>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>> Cc: linux-man <linux-man@vger.kernel.org>
>> Signed-off-by: Omar Sandoval <osandov@fb.com>
>> ---
>> This feature is not yet upstream.
>>
>>  man2/fcntl.2      |  10 +-
>>  man2/open.2       |  23 +++
>>  man2/readv.2      |  70 +++++++++
>>  man7/encoded_io.7 | 369 ++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 471 insertions(+), 1 deletion(-)
>>  create mode 100644 man7/encoded_io.7
>>
>> diff --git a/man2/fcntl.2 b/man2/fcntl.2
>> index 546016617..b0d7fa2c3 100644
>> --- a/man2/fcntl.2
>> +++ b/man2/fcntl.2
>> @@ -221,8 +221,9 @@ On Linux, this command can change only the
>>  .BR O_ASYNC ,
>>  .BR O_DIRECT ,
>>  .BR O_NOATIME ,
>> +.BR O_NONBLOCK ,
>>  and
>> -.B O_NONBLOCK
>> +.B O_ALLOW_ENCODED
>>  flags.
>>  It is not possible to change the
>>  .BR O_DSYNC
>> @@ -1820,6 +1821,13 @@ Attempted to clear the
>>  flag on a file that has the append-only attribute set.
>>  .TP
>>  .B EPERM
>> +Attempted to set the
>> +.B O_ALLOW_ENCODED
>> +flag and the calling process did not have the
>> +.B CAP_SYS_ADMIN
>> +capability.
>> +.TP
>> +.B EPERM
>>  .I cmd
>>  was
>>  .BR F_ADD_SEALS ,
>> diff --git a/man2/open.2 b/man2/open.2
>> index f587b0d95..84697dfa8 100644
>> --- a/man2/open.2
>> +++ b/man2/open.2
>> @@ -437,6 +437,16 @@ was followed by a call to
>>  .BR fdatasync (2)).
>>  .IR "See NOTES below" .
>>  .TP
>> +.B O_ALLOW_ENCODED
> 
> The list is alphabetically sorted;
> please, follow that
> (O_ALLOW_ENCODED should be the first one).
> 
>> +Open the file with encoded I/O permissions;
>> +see
>> +.BR encoded_io (7).
>> +.B O_CLOEXEC
>> +must be specified in conjuction with this flag.
>> +The caller must have the
>> +.B CAP_SYS_ADMIN
>> +capability.
>> +.TP
>>  .B O_EXCL
>>  Ensure that this call creates the file:
>>  if this flag is specified in conjunction with
>> @@ -1082,6 +1092,14 @@ is invalid
>>  (e.g., it contains characters not permitted by the underlying filesystem).
>>  .TP
>>  .B EINVAL
>> +.B O_ALLOW_ENCODED
>> +was specified in
>> +.IR flags ,
>> +but
>> +.B O_CLOEXEC
>> +was not specified.
>> +.TP
>> +.B EINVAL
>>  The final component ("basename") of
>>  .I pathname
>>  is invalid
>> @@ -1238,6 +1256,11 @@ did not match the owner of the file and the caller was not privileged.
>>  The operation was prevented by a file seal; see
>>  .BR fcntl (2).
>>  .TP
>> +.B EPERM
>> +The
>> +.B O_ALLOW_ENCODED
>> +flag was specified, but the caller was not privileged.
>> +.TP
>>  .B EROFS
>>  .I pathname
>>  refers to a file on a read-only filesystem and write access was
>> diff --git a/man2/readv.2 b/man2/readv.2
>> index 5a8b74168..c9933acf0 100644
>> --- a/man2/readv.2
>> +++ b/man2/readv.2
>> @@ -264,6 +264,11 @@ the data is always appended to the end of the file.
>>  However, if the
>>  .I offset
>>  argument is \-1, the current file offset is updated.
>> +.TP
>> +.BR RWF_ENCODED " (since Linux 5.12)"
>> +Read or write encoded (e.g., compressed) data.
>> +See
>> +.BR encoded_io (7).
>>  .SH RETURN VALUE
>>  On success,
>>  .BR readv (),
>> @@ -283,6 +288,13 @@ than requested (see
>>  and
>>  .BR write (2)).
>>  .PP
>> +If
>> +.B
>> +RWF_ENCODED
> 
> RWF_ENCODED should go in the same line as .B:
> 
> [
> .B RWF_ENCODED
> ]
> 
>> +was specified in
>> +.IR flags ,
>> +then the return value is the number of encoded bytes.
>> +.PP
>>  On error, \-1 is returned, and \fIerrno\fP is set appropriately.
>>  .SH ERRORS
>>  The errors are as given for
>> @@ -313,6 +325,64 @@ is less than zero or greater than the permitted maximum.
>>  .TP
>>  .B EOPNOTSUPP
>>  An unknown flag is specified in \fIflags\fP.
>> +.TP
>> +.B EOPNOTSUPP
>> +.B RWF_ENCODED
>> +is specified in
>> +.I flags
>> +and the filesystem does not implement encoded I/O.
>> +.TP
>> +.B EPERM
>> +.B RWF_ENCODED
>> +is specified in
>> +.I flags
>> +and the file was not opened with the
>> +.B O_ALLOW_ENCODED
>> +flag.
>> +.PP
>> +.BR preadv2 ()
>> +can fail for the following reasons:
> 
> The wording is a bit unclear:
> 
> Above your additions (old text, not yours),
> it says that some errors apply to preadv2
> (as well as to other functions):
> 
> [
> ERRORS
>        The errors are as given for read(2) and write(2).  Furthermore,
>        preadv(),  preadv2(),  pwritev(),  and pwritev2() can also fail
>        for the same reasons as lseek(2).  Additionally, the  following
>        errors are defined:
> 
>        EINVAL The  sum  of  the  iov_len  values  overflows an ssize_t
>               value.
> 
>        EINVAL The vector count, iovcnt, is less than zero  or  greater
>               than the permitted maximum.
> 
>        EOPNOTSUPP
>               An unknown flag is specified in flags.
> 
>        EOPNOTSUPP
>               RWF_ENCODED  is  specified  in  flags and the filesystem
>               does not implement encoded I/O.
> 
>        EPERM  RWF_ENCODED is specified in flags and the file  was  not
>               opened with the O_ALLOW_ENCODED flag.
> ]
> 
> And then you added a line that says:
> 
> [
>        preadv2() can fail for the following reasons:
> ]
> 
> Which if read strictly, it says that [only] the following errors apply.
> 
> Did you mean that
> "preadv3() can _additionally_ fail for the following reasons"?
> 
> Could you please be a bit more specific?
> 
> The same applies for pwritev2() below.
> 
>> +.TP
>> +.B E2BIG
>> +.B RWF_ENCODED
>> +is specified in
>> +.I flags
>> +and
>> +.I iov[0]
>> +is not large enough to return the encoding metadata.
>> +.TP
>> +.B ENOBUFS
>> +.B RWF_ENCODED
>> +is specified in
>> +.I flags
>> +and the buffers in
>> +.I iov
>> +are not big enough to return the encoded data.
>> +.PP
>> +.BR pwritev2 ()
>> +can fail for the following reasons:
>> +.TP
>> +.B E2BIG
>> +.B RWF_ENCODED
>> +is specified in
>> +.I flags
>> +and
>> +.I iov[0]
>> +contains non-zero fields
>> +after the kernel's
>> +.IR "sizeof(struct\ encoded_iov)" .
> 
> Don't escape the space, if the string is already in "".
> 
>> +.TP
>> +.B EINVAL
>> +.B RWF_ENCODED
>> +is specified in
>> +.I flags
>> +and the encoding is unknown or not supported by the filesystem.
>> +.TP
>> +.B EINVAL
>> +.B RWF_ENCODED
>> +is specified in
>> +.I flags
>> +and the alignment and/or size requirements are not met.
>>  .SH VERSIONS
>>  .BR preadv ()
>>  and
>> diff --git a/man7/encoded_io.7 b/man7/encoded_io.7
>> new file mode 100644
>> index 000000000..106fa587b
>> --- /dev/null
>> +++ b/man7/encoded_io.7
>> @@ -0,0 +1,369 @@
>> +.\" Copyright (c) 2020 by Omar Sandoval <osandov@fb.com>
>> +.\"
>> +.\" %%%LICENSE_START(VERBATIM)
>> +.\" Permission is granted to make and distribute verbatim copies of this
>> +.\" manual provided the copyright notice and this permission notice are
>> +.\" preserved on all copies.
>> +.\"
>> +.\" Permission is granted to copy and distribute modified versions of this
>> +.\" manual under the conditions for verbatim copying, provided that the
>> +.\" entire resulting derived work is distributed under the terms of a
>> +.\" permission notice identical to this one.
>> +.\"
>> +.\" Since the Linux kernel and libraries are constantly changing, this
>> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
>> +.\" responsibility for errors or omissions, or for damages resulting from
>> +.\" the use of the information contained herein.  The author(s) may not
>> +.\" have taken the same level of care in the production of this manual,
>> +.\" which is licensed free of charge, as they might when working
>> +.\" professionally.
>> +.\"
>> +.\" Formatted or processed versions of this manual, if unaccompanied by
>> +.\" the source, must acknowledge the copyright and authors of this work.
>> +.\" %%%LICENSE_END
>> +.\"
>> +.\"
>> +.TH ENCODED_IO  7 2020-11-11 "Linux" "Linux Programmer's Manual"
>> +.SH NAME
>> +encoded_io \- overview of encoded I/O
>> +.SH DESCRIPTION
>> +Several filesystems (e.g., Btrfs) support transparent encoding
>> +(e.g., compression, encryption) of data on disk:
>> +written data is encoded by the kernel before it is written to disk,
>> +and read data is decoded before being returned to the user.
>> +In some cases, it is useful to skip this encoding step.
> 
> Here I would use ';' instead of '.'
> (and next letter would be lowercase, then).
> 
>> +For example, the user may want to read the compressed contents of a file
>> +or write pre-compressed data directly to a file.
>> +This is referred to as "encoded I/O".
>> +.SS Encoded I/O API
>> +Encoded I/O is specified with the
>> +.B RWF_ENCODED
>> +flag to
>> +.BR preadv2 (2)
>> +and
>> +.BR pwritev2 (2).
>> +If
>> +.B RWF_ENCODED
>> +is specified, then
>> +.I iov[0].iov_base
>> +points to an
>> +.I
>> +encoded_iov
> 
> On the same line, please.
> 
>> +structure, defined in
>> +.I <linux/fs.h>
>> +as:
>> +.PP
>> +.in +4n
>> +.EX
>> +struct encoded_iov {
>> +    __aligned_u64 len;
>> +    __aligned_u64 unencoded_len;
>> +    __aligned_u64 unencoded_offset;
>> +    __u32 compression;
>> +    __u32 encryption;
>> +};
>> +.EE
>> +.in
>> +.PP
>> +This may be extended in the future, so
>> +.I iov[0].iov_len
>> +must be set to
>> +.I "sizeof(struct\ encoded_iov)"
>> +for forward/backward compatibility.
>> +The remaining buffers contain the encoded data.
>> +.PP
>> +.I compression
>> +and
>> +.I encryption
>> +are the encoding fields.
>> +.I compression
>> +is
>> +.B ENCODED_IOV_COMPRESSION_NONE
>> +(zero)
>> +or a filesystem-specific
>> +.B ENCODED_IOV_COMPRESSION
> 
> Maybe s/ENCODED_IOV_COMPRESSION/ENCODED_IOV_COMPRESSION_*/

Or s/ENCODED_IOV_COMPRESSION/ENCODED_IOV_COMPRESSION_/

I'm not sure about existing practice.

Michael (mtk), what would you do here?

> 
>> +constant;
>> +see
>> +.BR Filesystem\ support .
> 
> Please, write it as [.BR "Filesystem support" .]
> 
> and maybe I would change it, to be more specific, to the following:
> 
> [
> see
> .B Filesystem support
> below.
> ]
> 
> So that the reader clearly understands it's on the same page.
> 
>> +.I encryption
>> +is currently always
>> +.B ENCODED_IOV_ENCRYPTION_NONE
>> +(zero).
>> +.PP
>> +.I unencoded_len
>> +is the length of the unencoded (i.e., decrypted and decompressed) data.
>> +.I unencoded_offset
>> +is the offset into the unencoded data where the data in the file begins
> 
> The above wording is a bit unclear to me.
> 
> I suggest the following:
> 
> [
> .I unencoded_offset
> is the offset from the begining of the file
> to the first byte of the unencoded data
> ]
> 
>> +(less than or equal to
>> +.IR unencoded_len ).
>> +.I len
>> +is the length of the data in the file
>> +(less than or equal to
>> +.I unencoded_len
>> +-
> 
> Here's a question for Michael (mtk):
> 
> I've seen (many) cases where these math operations
> are written without spaces,
> and in the same line (e.g., [.IR a + b]).
> 
> I'd like to know your preferences on this,
> or what is actually more extended in the manual pages,
> to stick with only one of them.
> 
>> +.IR unencoded_offset ).
>> +See
>> +.B Extent layout
>> +below for some examples.
>> +.I
> 
> Were you maybe going to add something there?
> 
> If not, please remove that [.I].
> 
>> +.PP
>> +If the unencoded data is actually longer than
>> +.IR unencoded_len ,
>> +then it is truncated;
>> +if it is shorter, then it is extended with zeroes.
>> +.PP
>> +
> 
> Please, remove that blank line.
> 
>> +.BR pwritev2 ()
> 
> Should be [.BR pwritev2 (2)]
> 
> Michael (mtk),
> 
> Am I right in that?  Please, confirm.
> 
>> +uses the metadata specified in
>> +.IR iov[0] ,
>> +writes the encoded data from the remaining buffers,
>> +and returns the number of encoded bytes written
>> +(that is, the sum of
>> +.I iov[n].iov_len
>> +for 1 <=
>> +.I n
>> +<
>> +.IR iovcnt ;
>> +partial writes will not occur).
>> +At least one encoding field must be non-zero.
>> +Note that the encoded data is not validated when it is written;
>> +if it is not valid (e.g., it cannot be decompressed),
>> +then a subsequent read may return an error.
>> +If the
>> +.I offset
>> +argument to
>> +.BR pwritev2 ()
> 
> Same as above: specify (2).
> 
>> +is -1, then the file offset is incremented by
>> +.IR len .
>> +If
>> +.I iov[0].iov_len
>> +is less than
>> +.I "sizeof(struct\ encoded_iov)"
> 
> [.I] allows spaces, so it should be:
> 
> [
> .I sizeof(struct encoded_iov)
> ]
> 
>> +in the kernel,
>> +then any fields unknown to userspace are treated as if they were zero;
> 
> s/userspace/user space/
> 
> See man-pages(7)::STYLE GUIDE::Preferred terms
> 
>> +if it is greater and any fields unknown to the kernel are non-zero,
>> +then this returns -1 and sets
>> +.I errno
>> +to
>> +.BR E2BIG .
>> +.PP
>> +.BR preadv2 ()
> 
> Same as above: specify (2).
> 
>> +populates the metadata in
>> +.IR iov[0] ,
>> +the encoded data in the remaining buffers,
>> +and returns the number of encoded bytes read.
>> +This will only return one extent per call.
>> +This can also read data which is not encoded;
>> +all encoding fields will be zero in that case.
>> +If the
>> +.I offset
>> +argument to
>> +.BR preadv2 ()
> 
> Smae as above: specify (2).
> 
>> +is -1, then the file offset is incremented by
>> +.IR len .
>> +If
>> +.I iov[0].iov_len
>> +is less than
>> +.I "sizeof(struct\ encoded_iov)"
> 
> Don't need '"' nor '\', as above.
> 
>> +in the kernel and any fields unknown to userspace are non-zero,
> 
> s/userspace/user space/
> 
>> +then
>> +.BR preadv2 ()
> 
> (2)
> 
>> +returns -1 and sets
>> +.I errno
>> +to
>> +.BR E2BIG ;
>> +if it is greater,
>> +then any fields unknown to the kernel are returned as zero.
>> +If the provided buffers are not large enough to return an entire encoded
>> +extent,
> 
> Please use semantic newlines.
> I haven't checked that in the text above,
> so if you happen to find that there's any other line
> that should also be fixed in that sense, please do so.
> 
> To understand 'semantic newlines',
> please have a look at
> man-pages(7)::STYLE GUIDE::Use semantic newlines
> 
> Basically, split lines at the most natural separation point,
> instead of just when the line gets over the margin.
> 
>> +then
>> +.BR preadv2 ()
> 
> (2)
> 
>> +returns -1 and sets
>> +.I errno
>> +to
>> +.BR ENOBUFS .
>> +.PP
>> +As the filesystem page cache typically contains decoded data,
>> +encoded I/O bypasses the page cache.
>> +.SS Extent layout
>> +By using
>> +.IR len ,
>> +.IR unencoded_len ,
>> +and
>> +.IR unencoded_offset ,
>> +it is possible to refer to a subset of an unencoded extent.
>> +.PP
>> +In the simplest case,
>> +.I len
>> +is equal to
>> +.I unencoded_len
>> +and
>> +.I unencoded_offset
>> +is zero.
>> +This means that the entire unencoded extent is used.
>> +.PP
>> +However, suppose we read 50 bytes into a file
>> +which contains a single compressed extent.
>> +The filesystem must still return the entire compressed extent
>> +for us to be able to decompress it,
>> +so
>> +.I unencoded_len
>> +would be the length of the entire decompressed extent.
>> +However, because the read was at offset 50,
>> +the first 50 bytes should be ignored.
>> +Therefore,
>> +.I unencoded_offset
>> +would be 50,
>> +and
>> +.I len
>> +would accordingly be
>> +.IR unencoded_len\ -\ 50 .
> 
> This formats everything as I, except for the last dot.
> Replace by:
> 
> [
> .I unencoded
> - 50.
> ]
> 
> Michael (mtk), same as above:
> to space, or not to space?  That is the question :p
> 
> Personally, I find spaces more clear.
> 
>> +.PP
>> +Additionally, suppose we want to create an encrypted file with length 500,
>> +but the file is encrypted with a block cipher using a block size of 4096.
>> +The unencoded data would therefore include the appropriate padding,
>> +and
>> +.I unencoded_len
>> +would be 4096.
>> +However, to represent the logical size of the file,
>> +.I len
>> +would be 500
>> +(and
>> +.I unencoded_offset
>> +would be 0).
>> +.PP
>> +Similar situations can arise in other cases:
>> +.IP * 3
>> +If the filesystem pads data to the filesystem block size before compressing,
>> +then compressed files with a size unaligned to the filesystem block size will
>> +end with an extent with
>> +.I len
>> +<
>> +.IR unencoded_len .
>> +.IP *
>> +Extents cloned from the middle of a larger encoded extent with
>> +.B FICLONERANGE
>> +may have a non-zero
>> +.I unencoded_offset
>> +and/or
>> +.I len
>> +<
>> +.IR unencoded_len .
>> +.IP *
>> +If the middle of an encoded extent is overwritten,
>> +the filesystem may create extents with a non-zero
>> +.I unencoded_offset
>> +and/or
>> +.I len
>> +<
>> +.I unencoded_len
>> +for the parts that were not overwritten.
>> +.SS Security
>> +Encoded I/O creates the potential for some security issues:
>> +.IP * 3
>> +Encoded writes allow writing arbitrary data which the kernel will decode on
>> +a subsequent read. Decompression algorithms are complex and may have bugs
>> +which can be exploited by maliciously crafted data.
>> +.IP *
>> +Encoded reads may return data which is not logically present in the file
>> +(see the discussion of
>> +.I len
>> +vs.
> 
> Please, s/vs./vs/
> See the reasons below:
> 
> Michael (mtk),
> 
> Here the renderer outputs a double space
> (as for separating two sentences).
> 
> Are you okay with that?
> 
> I haven't found any other "\<vs\>\.".
> However, I've found a few "\<vs\>[^\.]".
> 
>> +.I unencoded_len
>> +above).
>> +It may not be intended for this data to be readable.
>> +.PP
>> +Therefore, encoded I/O requires privilege.
>> +Namely, the
>> +.B RWF_ENCODED
>> +flag may only be used when the file was opened with the
>> +.B O_ALLOW_ENCODED
>> +flag to
>> +.BR open (2),
>> +which requires the
>> +.B CAP_SYS_ADMIN
>> +capability.
>> +The
>> +.B O_CLOEXEC
>> +flag must be specified in conjunction with
>> +.BR O_ALLOW_ENCODED .
>> +This avoids accidentally leaking the encoded I/O privilege
>> +(it is not cleared on
>> +.BR fork (2)
>> +or
>> +.BR execve (2)
>> +otherwise).
>> +If
>> +.B O_ALLOW_ENCODED
>> +without
>> +.B O_CLOEXEC
>> +is desired,
>> +.B O_CLOEXEC
>> +can be cleared afterwards with
>> +.BR fnctl (2).
>> +.BR fcntl (2)
>> +can also clear or set
>> +.B O_ALLOW_ENCODED
>> +(including without
>> +.BR O_CLOEXEC ).
>> +.SS Filesystem support
>> +Encoded I/O is supported on the following filesystems:
>> +.TP
>> +Btrfs (since Linux 5.12)
>> +.IP
>> +Btrfs supports encoded reads and writes of compressed data.
>> +The data is encoded as follows:
>> +.RS
>> +.IP * 3
>> +If
>> +.I compression
>> +is
>> +.BR ENCODED_IOV_COMPRESSION_BTRFS_ZLIB ,
>> +then the encoded data is a single zlib stream.
>> +.IP *
>> +If
>> +.I compression
>> +is
>> +.BR ENCODED_IOV_COMPRESSION_BTRFS_ZSTD ,
>> +then the encoded data is a single zstd frame compressed with the
>> +.I windowLog
>> +compression parameter set to no more than 17.
>> +.IP *
>> +If
>> +.I compression
>> +is one of
>> +.BR ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K ,
>> +.BR ENCODED_IOV_COMPRESSION_BTRFS_LZO_8K ,
>> +.BR ENCODED_IOV_COMPRESSION_BTRFS_LZO_16K ,
>> +.BR ENCODED_IOV_COMPRESSION_BTRFS_LZO_32K ,
>> +or
>> +.BR ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K ,
>> +then the encoded data is compressed page by page
>> +(using the page size indicated by the name of the constant)
>> +with LZO1X
>> +and wrapped in the format documented in the Linux kernel source file
>> +.IR fs/btrfs/lzo.c .
>> +.RE
>> +.IP
>> +Additionally, there are some restrictions on
>> +.BR pwritev2 ():
> 
> (2)
> 
>> +.RS
>> +.IP * 3
>> +.I offset
>> +(or the current file offset if
>> +.I offset
>> +is -1) must be aligned to the sector size of the filesystem.
>> +.IP *
>> +.I len
>> +must be aligned to the sector size of the filesystem
>> +unless the data ends at or beyond the current end of the file.
>> +.IP *
>> +.I unencoded_len
>> +and the length of the encoded data must each be no more than 128 KiB.
>> +This limit may increase in the future.
>> +.IP *
>> +The length of the encoded data must be less than or equal to
>> +.IR unencoded_len .
>> +.IP *
>> +If using LZO, the filesystem's page size must match the compression page size.
>> +.RE
>>
> 
> Please, add a SEE ALSO section, which should at least point to
> preadv2(2) (or pwritev2(2), if you prefer):
> 
> [
> .SH SEE ALSO
> .BR preadv2 (2)
> ]
> 
