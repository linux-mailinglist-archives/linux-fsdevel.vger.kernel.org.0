Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7726368EE97
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 13:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjBHMJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 07:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBHMJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:09:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96C111651;
        Wed,  8 Feb 2023 04:09:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bu23so672570wrb.8;
        Wed, 08 Feb 2023 04:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGafubzmHRRH6UHRpA5a7k29P/gBmV50GLONDcRP9tI=;
        b=OpDwTXHnq1CS8kuQCMMQjoDOIsCRJPxSSN5euXdgkvAdI6f2RwAnHMU4yGwyiQe1dj
         BvbBCTrgT2rwYozNWozVACkVspwEMzh5uEtMbyhzkWS+HGvEeLdlDyg9NjUyOtRgBeu7
         tTszt+gJNwH6sfB8tR546UGp651CskoSnzYVPTHXmswascLBcLbyVl8K3qgjw8xMXglL
         DD6NxerciQGOK71VNZnGvQQWZrWpCcpNBQfxFIyJCpoZZRL7qc2baRKSpxEmODRR8JXd
         SB1A2XyLnK04w1NOgmYvcR0obO5+M5YRmCp2NphEG9tze+8B3FRRrQP9OMoMYG8/Mae7
         Dokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rGafubzmHRRH6UHRpA5a7k29P/gBmV50GLONDcRP9tI=;
        b=fyrErsMaaJ3LUA+tXK0F3imxVQgn9tW628RtUpXQsMz6yM05UZ87Aihop5R6mpJ4o8
         2JXQJdb0SJeACTaH9drNtJ3ocrpHocl0sEM0v1yjtGFzYywuAsdYI29FkBl8WPVCnQxA
         UN3VmEeQs6ea+Lg42bpcz24hovooOgtRp/Evhd8o2fjtr77M7hsyr9LtyArJCEjCQUiD
         YewS/JNX1SZGmw79rqq1e66VFLvh0t8mztgTzlvu+zbK4LyQ9mQXAXlIu7eYNknFJGev
         DtWhrngLxEckm2cARwyjS/e9ecH8YLzhTn7ZKlVZGLTQ1TbfT4gCBuuTNyht4MtTNaKB
         dpGQ==
X-Gm-Message-State: AO0yUKUGmpaBJDctBBRBN5xmYQNO7Zr0XJXZ5olFQU2sX2Aqb67QS3z2
        hoAaJ3vwBuLpooxReQWbGyvkBiMOUa8+Q6uh
X-Google-Smtp-Source: AK7set/0LdX34TF42BDs2yb6m8k8qFh+7X8TJYxLo5Uy3rR/6EYZgm5w+Xa0tgTmsWrb5fYtkRbe2g==
X-Received: by 2002:adf:f60f:0:b0:2c3:dc62:e680 with SMTP id t15-20020adff60f000000b002c3dc62e680mr6328158wrp.30.1675858192347;
        Wed, 08 Feb 2023 04:09:52 -0800 (PST)
Received: from [192.168.1.107] (pop.92-184-100-160.mobile.abo.orange.fr. [92.184.100.160])
        by smtp.gmail.com with ESMTPSA id e7-20020adfdbc7000000b002425be3c9e2sm12637824wrj.60.2023.02.08.04.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 04:09:51 -0800 (PST)
Message-ID: <03a87391-1b19-de2d-5c18-581c1d0c47ca@gmail.com>
Date:   Wed, 8 Feb 2023 13:09:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
From:   Sebastien Buisson <sbuisson.work@gmail.com>
Subject: Backup/restore of fscrypt files and directories
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am planning to implement backup and restore for fscrypt files and 
directories and propose the following design, and would welcome feedback 
on this approach.

There is a need to preserve encrypted file data in case of storage 
failure and to allow safely moving the data between filesystems and 
systems without decrypting it, just like we would do for normal files. 
While backup and restore at the device level is sometimes an option, we 
need to also be able to carry out back/restore at the ext4 file system 
level, for instance to allow changing formatting options.

The core principle we want to retain is that we must not make any clear 
text copy of encrypted files. This means backup/restore must be carried 
out without the encryption key.

The first challenge we have to address is to get access to raw encrypted 
files without the encryption key. By design, fscrypt does not allow such 
kind of access, and the ext4 file system would not let read or write 
files flagged as encrypted if the encryption key is not provided. This 
restriction is not for security reasons, but to avoid applications 
accidentally accessing the ciphertext. A mechanism must be provided for 
access to both raw encrypted content, and raw encrypted names.

The second challenge is to deal with the encrypted file's size, when it 
is accessed with the encryption key vs. when accessed without the 
encryption key. For the backup operation to retrieve full encrypted 
content, the encrypted file size should be reported as a multiple of the 
encryption chunk size when the encryption key is not present. And the 
clear text file size (size as seen with the encryption key) must be 
backed up as well in order to properly restore encrypted files later on. 
This information cannot be inferred by any other means.

The third challenge is to get access to the encryption context of files 
and directories. By design, fscrypt does not expose this information, 
internally stored as an extended attribute but with no associated 
handler. However, making a backup of the encryption context is crucial 
because it preserves the information needed to later decrypt the file 
content. And it is also a non-trivial operation to restore the 
encryption context. Indeed, fscrypt imposes that an encryption context 
can only be set on a new file or an existing but empty directory.


In order to address this need for backup/restore of encrypted files, we 
propose to make use of a special extended attribute named 
security.encdata, containing:
- encoding method used for binary data. Assume name can be up to 255 chars.
- clear text file data length in bytes (set to 0 for dirs).
- encryption context. 40 bytes for v2 encryption context.
- encrypted name. 256 bytes max.

To improve portability if we need to change the on-disk format in the 
future, and to make the archived data useful over a longer timeframe, 
the content of the security.encdata xattr is expressed as ASCII text 
with a "key: value" YAML format. As encryption context and encrypted 
file name are binary, they need to be encoded.
So the content of the security.encdata xattr would be something like:

   { encoding: base64url, size: 3012, enc_ctx: YWJjZGVmZ2hpamtsbW
   5vcHFyc3R1dnd4eXphYmNkZWZnaGlqa2xtbg, enc_name: ZmlsZXdpdGh2ZX
   J5bG9uZ25hbWVmaWxld2l0aHZlcnlsb25nbmFtZWZpbGV3aXRodmVyeWxvbmdu
   YW1lZmlsZXdpdGg }

Because base64 encoding has a 33% overhead, this gives us a maximum 
xattr size of approximately 800 characters.
This extended attribute would not be shown when listing xattrs, only 
exposed when fetched explicitly, and unmodified tools would not be able 
to access the encrypted files in any case. It would not be stored on 
disk, only computed when fetched.


File and file system backups often use the tar utility either directly 
or under the covers. We propose to modify the tar utility to make it 
"encryption aware", but the same relatively small changes could be done 
with other common backup utilities like cpio as needed. When detecting 
ext4 encrypted files, tar would need to explicitly fetch the 
security.encdata extended attribute, and store it along with the backup 
file. Fetching this extended attribute would internally trigger in ext4 
a mechanism responsible for gathering the required information. Because 
we must not make any clear text copy of encrypted files, the encryption 
key must not be present. Tar would also need to use a special flag that 
would allow reading raw data without the encryption key. Such a flag 
could be named O_FILE_ENC, and would need to be coupled with O_DIRECT so 
that the page cache does not see this raw data. O_FILE_ENC could take 
the value of (O_NOCTTY | O_NDELAY) as they are unlikely to be used in 
practice and are not harmful if used incorrectly. The name of the 
backed-up file would be the encoded+digested form returned by fscrypt.

The tar utility would be used to extract a previously created tarball 
containing encrypted files. When restoring the security.encdata extended 
attribute, instead of storing the xattr as-is on disk, this would 
internally trigger in ext4 a mechanism responsible for extracting the 
required information, and storing them accordingly. Tar would also need 
to specify the O_FILE_ENC | O_DIRECT flags to write raw data without the 
encryption key.

To create a valid encrypted file with proper encryption context and 
encrypted name, we can implement a mechanism where the file is first 
created with O_TMPFILE in the encrypted directory to avoid triggering 
the encryption context check before setting the security.encdata xattr, 
and then atomically linking it to the namespace with the correct 
encrypted name.


 From a security standpoint, doing backup and restore of encrypted files 
must not compromise their security. This is the reason why we want to 
carry out these operations without the encryption key. It avoids making 
a clear text copy of encrypted files.
The security.encdata extended attribute contains the encryption context 
of the file or directory. This has a 16-byte nonce (per-file random 
value) that is used along with the master key to derive the per-file key 
thanks to a KDF function. But the master key is not stored in ext4, so 
it is not backed up as part of the scenario described above, which makes 
the backup of the raw encrypted files safe.
The process of restoring encrypted files must not change the encryption 
context associated with the files. In particular, setting an encryption 
context on a file must be possible only once, when the file is restored. 
And the newly introduced capability of restoring encrypted files must 
not give the ability to set an arbitrary encryption context on files.


 From the backup tool point of view, the only changes needed would be to 
add "O_FILE_ENC" when the open fails with ENOKEY, and then explicitly 
backup the "security.encdata" xattr with the file.  On restore, if the 
"security.encdata" xattr is present, then the file should be created in 
the directory with O_TMPFILE before restoring the xattrs and file data, 
and then using link() to link the file to the directory with the 
encrypted filename.

 From the filesystem point of view, it needs to generate the encdata 
xattr on getxattr(), and interpret it correctly on setxattr().  The VFS 
needs to allow open() and link() on encrypted files with O_FILE_ENC.

If this proposal is OK I can provide a series of patches to implement this.

