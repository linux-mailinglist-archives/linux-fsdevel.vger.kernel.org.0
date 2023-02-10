Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4BA691FFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 14:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjBJNog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 08:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjBJNoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:44:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E00173963;
        Fri, 10 Feb 2023 05:44:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j25so5120086wrc.4;
        Fri, 10 Feb 2023 05:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pc5pcVCa1LtRQH5wWNer+/cZf3S6touB5+PwKxQUc8s=;
        b=AR/Dnrmo/3GSnoOieuReB0XDrYiTcNjT82xP0xVhHj6GMfhTzW5qEJyr8tCpN/NgJd
         OJkYgio9ADm9yDzX4Jh7SLCwDAjnhwLkZ0ogzhJzS1tGGLJQf8YbEVxHcxhr+89LMr9e
         xssj6t409Ta0Aw7sAgk8SJm1ZSWBk1Dz5h1IUvgeyPCE1LiF2/s35iu43eAUjk4ViB4c
         tvTV83B8WWF/p09uWPwlGy/JW8PycilCmZB6EbIYog0TZOr0cQ/gMS8KnZLeKXd7IKJX
         kQDBg/61S9Vypfjf6g1b/F07zaYgj2RuuDucjD60kPZDwaaMR4VBAoTZBcPca3N1sAVK
         E+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pc5pcVCa1LtRQH5wWNer+/cZf3S6touB5+PwKxQUc8s=;
        b=joN36pt/S4iexu4qV+R+7DGUvULKC/zOlSfIzzyCtQdwt9xcIRnXkv3Q1m8BsBSjVN
         oXcL3TnbFsUcVvUqdjLT3q01n7DBDELu6lVQ2rTC1c0R4eHxX/J5qvHoOOQkbmKMBJ/e
         s/bHLj/hmqaL8C4sixy1iJDRX3sMMNdfaYIZ7Wv14OMOCMMc76zNpfCbjmrHKx38JdFF
         WrxG5QXfAywNkkO4tzEbtjsBziughlY5RwsU1EOYpgpT1//lgqOmJj0GAF00eNz2GBpj
         WiELusPjYoFPPTpBiVD+oY1q4Ova5/lC2ccjAgfLMgf+eFaFcR6coDNYTLzyvQX3wPoA
         dFag==
X-Gm-Message-State: AO0yUKXd0zyufODRP6nT9QDuDmsEx9mRXCenOWTtw6px4Z3i85RlqLTg
        J1kuIi921PRIQX0lU2yLjgk=
X-Google-Smtp-Source: AK7set/Bl/CA2BJ1BE9cS8txjbMCUARkUwTecxnXIqR3YKC1e9TEuHugWfIiOCrSseBigpFbP9R6HQ==
X-Received: by 2002:adf:fe86:0:b0:2bf:ac3f:a9da with SMTP id l6-20020adffe86000000b002bfac3fa9damr14317874wrr.7.1676036667630;
        Fri, 10 Feb 2023 05:44:27 -0800 (PST)
Received: from [192.168.2.100] (pop.92-184-112-173.mobile.abo.orange.fr. [92.184.112.173])
        by smtp.gmail.com with ESMTPSA id q5-20020adff785000000b002c3e89039casm3682544wrp.12.2023.02.10.05.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 05:44:26 -0800 (PST)
Message-ID: <0eaf08a8-ddec-5158-ab2b-ae7e3e1bab9b@gmail.com>
Date:   Fri, 10 Feb 2023 14:44:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: Backup/restore of fscrypt files and directories
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <03a87391-1b19-de2d-5c18-581c1d0c47ca@gmail.com>
 <Y+P3wumJK/znOKgl@gmail.com>
From:   Sebastien Buisson <sbuisson.work@gmail.com>
In-Reply-To: <Y+P3wumJK/znOKgl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

Thanks for your feedback.

Le 08/02/2023 à 20:28, Eric Biggers a écrit :
> Hi Sebastien,
>
> On Wed, Feb 08, 2023 at 01:09:50PM +0100, Sebastien Buisson wrote:
>> I am planning to implement backup and restore for fscrypt files and
>> directories and propose the following design, and would welcome feedback on
>> this approach.
> Thanks for looking into this.  Before getting too far into the details of your
> proposal, are you aware of the previous threads about this?  Specifically:
>
> "backup/restore of fscrypt files"
> (https://lore.kernel.org/linux-fscrypt/D1AD7D55-94D6-4C19-96B4-BAD0FD33CF49@dilger.ca/T/#u)
>
> And the discussion that happened as part of
> "[PATCH RERESEND v9 0/9] fs: interface for directly reading/writing compressed data"
> (https://lore.kernel.org/linux-fsdevel/CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com
> and its responses).

I knew about the first one, but had not stumbled accross the discussion 
that happened in the compression related thread, thanks.

> Both times before, it was brought up that the hardest part is backing up and
> restoring the filenames, including symlinks.  I don't think your proposal really
> addresses that.  Your proposal has a single filename in the security.encdata
> xattr.  But actually, a file can have many names.  Also, a file can have an
> encrypted name without being encrypted itself; that's the case for device node,
> socket, and FIFO files.  Also, symlinks have their target encrypted.

That is correct. The value of the enc_name field is the ciphertext name 
of the current dentry. Like with regular files, my impression was that 
tar (or the backup utility) would handle the hard links properly. 
According to you, what would make a difference between regular files and 
encrypted files regarding restore or hard links?

As for symlinks, you are right I need to dig further. I think at least 
the security.encdata xattr would need an additional field to hold the 
ciphertext symlink target.

> I think that your proposal, in general, needs more detail about how *restores*
> will work, since that's going to be much harder than backups.  It's not hard to
> get the filesystem to give you more information; it's much harder to make
> changes to a filesystem while keeping everything self-consistent!
>
> A description of the use cases of this feature would also be helpful.
> Historically, people have said they needed this feature when they really didn't.

There is really a need for backup/restore at the file system level. For 
instance, in case of storage failure, we would want to restore files to 
a newly formatted device, in a finner granularity that cannot be 
achieved with a backup/restore at the device level, or because that 
would allow changing formatting options. Also, it particularly makes 
sense to have per-directory backups, as the block devices are getting 
larger and larger.

The ability to backup and restore encrypted files is interesting in 
annother use case: moving files between file systems and systems without 
the need to decrypt then re-encrypt.

>> The third challenge is to get access to the encryption context of files and
>> directories. By design, fscrypt does not expose this information, internally
>> stored as an extended attribute but with no associated handler.
> Actually, FS_IOC_GET_ENCRYPTION_POLICY_EX and FS_IOC_GET_ENCRYPTION_NONCE
> together give you all the information stored in the encryption context.
>
>> In order to address this need for backup/restore of encrypted files, we
>> propose to make use of a special extended attribute named security.encdata,
>> containing:
>> - encoding method used for binary data. Assume name can be up to 255 chars.
>> - clear text file data length in bytes (set to 0 for dirs).
> st_size already gives the plaintext file length, even while the encryption key
> is not present.

Exactly, and that would prevent normal utilities from reading raw 
encrypted content up to the end of the encryption block (if access 
without the key was granted).

>> - encryption context. 40 bytes for v2 encryption context.
>> - encrypted name. 256 bytes max.
>>
>> To improve portability if we need to change the on-disk format in the
>> future, and to make the archived data useful over a longer timeframe, the
>> content of the security.encdata xattr is expressed as ASCII text with a
>> "key: value" YAML format. As encryption context and encrypted file name are
>> binary, they need to be encoded.
>> So the content of the security.encdata xattr would be something like:
>>
>>    { encoding: base64url, size: 3012, enc_ctx: YWJjZGVmZ2hpamtsbW
>>    5vcHFyc3R1dnd4eXphYmNkZWZnaGlqa2xtbg, enc_name: ZmlsZXdpdGh2ZX
>>    J5bG9uZ25hbWVmaWxld2l0aHZlcnlsb25nbmFtZWZpbGV3aXRodmVyeWxvbmdu
>>    YW1lZmlsZXdpdGg }
>>
>> Because base64 encoding has a 33% overhead, this gives us a maximum xattr
>> size of approximately 800 characters.
>> This extended attribute would not be shown when listing xattrs, only exposed
>> when fetched explicitly, and unmodified tools would not be able to access
>> the encrypted files in any case. It would not be stored on disk, only
>> computed when fetched.
> An xattr containing multiple key-value pairs is quite strange, since xattrs
> themselves are key-value pairs.  This could just be multiple xattrs.
>
> Did you choose this design because you intend for this to be treated as an
> opaque blob that userspace must not interpret at all?

This format is chosen to be readable and potentially modified if 
implementation of backup/restore of encrypted files evolves in the 
future. As you mention, some of the information returned in the 
security.encdata xattr can be retrieved by other means. But the idea to 
have a single xattr that holds all the information is to ease 
implementation in the backup/restore tools. For them, the backup 
operation would just consist in fetching the security.encdata xattr if 
dealing with an encrypted file. So from that standpoint, the content of 
the xattr is not supposed to be interpreted by the backup/restore tools. 
However, having a readable multi key-value pair format increases 
portability and makes it possible for other tools to convert to a newer 
format if the need arises in the future.

>> File and file system backups often use the tar utility either directly or
>> under the covers. We propose to modify the tar utility to make it
>> "encryption aware", but the same relatively small changes could be done with
>> other common backup utilities like cpio as needed. When detecting ext4
>> encrypted files, tar would need to explicitly fetch the security.encdata
>> extended attribute, and store it along with the backup file. Fetching this
>> extended attribute would internally trigger in ext4 a mechanism responsible
>> for gathering the required information. Because we must not make any clear
>> text copy of encrypted files, the encryption key must not be present.
> Why can't the encryption key be present during backup?  Surely some people are
> going to want to back up encrypted files consistently in ciphertext form,
> regardless of whether the key happens to be present or not at the particular
> time the backup is being done?  Consider e.g. a bunch of user home directories
> which are regularly being locked and unlocked, and the system administrator is
> taking backups of everything.
That is a very good question. Of course we do not want to make clear 
text copies of encrypted files, but you are right that we should also 
support making a ciphertext backup while the key is present. I guess 
this is achievable thanks to a specific flag to open() or preadv2() as 
mentioned below.
>> Tar
>> would also need to use a special flag that would allow reading raw data
>> without the encryption key. Such a flag could be named O_FILE_ENC, and would
>> need to be coupled with O_DIRECT so that the page cache does not see this
>> raw data. O_FILE_ENC could take the value of (O_NOCTTY | O_NDELAY) as they
>> are unlikely to be used in practice and are not harmful if used incorrectly.
> Maybe call this O_CIPHERTEXT?  Also note that a new RWF_* flag to preadv2,
> instead of a new O_* flag to open(), has been suggested before.
>
>> The name of the backed-up file would be the encoded+digested form returned
>> by fscrypt.
> Does this have a meaning, since the actual name would be stored separately?
But the backed-up file needs to have a name right? Given that the 
encoded+digested form returned by fscrypt is unique for the directory, I 
thought it would be fine to use. Can you think of another name to give 
to backed-up files?
>> The tar utility would be used to extract a previously created tarball
>> containing encrypted files. When restoring the security.encdata extended
>> attribute, instead of storing the xattr as-is on disk, this would internally
>> trigger in ext4 a mechanism responsible for extracting the required
>> information, and storing them accordingly. Tar would also need to specify
>> the O_FILE_ENC | O_DIRECT flags to write raw data without the encryption
>> key.
>>
>> To create a valid encrypted file with proper encryption context and
>> encrypted name, we can implement a mechanism where the file is first created
>> with O_TMPFILE in the encrypted directory to avoid triggering the encryption
>> context check before setting the security.encdata xattr, and then atomically
>> linking it to the namespace with the correct encrypted name.
> How exactly does the link to the correct name happen?  What if there's more than
> one name?  What about restoring non-regular files?

So the restore tool first creates the file with O_TMPFILE in the 
encrypted directory, and writes its ciphertext content (with a special 
flag mentioned above). Then the tool sets the security.encdata xattr. 
Internally fscrypt uses the value of the enc_ctx field to set the .c 
xattr on the file, and the size field to set the plaintext file length. 
The value of the enc_name field is stored temporarily by fscrypt in a 
dedicated xattr such as "ciphertextname". Then the tool calls linkat() 
on the file. Internally, seeing the special flag and the presence of the 
"ciphertextname" xattr, fscrypt uses this value as the new name.

The purpose of this is to impose the provided encryption context and 
encrypted name, instead of having new ones generated at file creation.

In the case of hard links, I do not know how tar for instance handles 
this for normal files. Do you have any ideas?


Cheers,

Sebastien.


>> The security.encdata extended attribute contains the encryption context of
>> the file or directory. This has a 16-byte nonce (per-file random value) that
>> is used along with the master key to derive the per-file key thanks to a KDF
>> function. But the master key is not stored in ext4, so it is not backed up
>> as part of the scenario described above, which makes the backup of the raw
>> encrypted files safe.
> Side note: the backup/restore support will need to be disabled on files that use
> FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64 or FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32, since
> those files are tied to the filesystem they are on.
>
> - Eric
