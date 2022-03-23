Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0300F4E5BBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 00:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbiCWXSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 19:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345006AbiCWXSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:18:41 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A8B90CD5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 16:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648077430; bh=v67yEHZF+mWrcVVVzQnTLeOFxfVlSQsXaIHjbMmzPxs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fxDxhCBcj+dJ9rOPsrfQhpR6/Wz1mNFTDfWRs0YRzO2PLESHajaFYw4fMVqGzApiKbWraCn4SHEhlSe5c+HJwApksHob1lFVM+tP7D0/MB2jQSf+QN6Hqz2CkNrflSYPmP6UIemIRohY+XAj73JqB7GB9zh6PE6zGm4E+cqp3Jqq0uyUoSZERN3H2x3qb+AXV0TFul1ch1yf55HhsY5+PufoAgZhmoRIg41a31AigqxpEhdh1HK0uDqxf0TROBKeb6Ze7PDWqrMuan952LJiqJjJ5kP8TpCNDjZ2qyqeWIZLKwNdCN2pW5ymvlT+wCU/FFIszlfv4QcxDRIMcRMz0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648077430; bh=N356eMqQgGrIXhRu8EunIkwCAUoK4yb9Y2saHGeSS/x=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hyZY6HP2zIE3582RMch80fwwA7NRVkWkvskGEqaBGzclP6VM2aRyyPiPSKoInK+ph3aAJag8EoWmTMIr9PjuBYo64Fse7aBcWswrnoST/xgfFcDJOc+quXlJ7fBs8bwkPOSJ8Tagf8OfqSFlgqmW1zznoNF3Np6GI1Qqlfmxr36wM3kIiDUIz/jRBCsJRbl68i2oGmbzHy9pacJE5/EecOL9VWXlLMzCmWWp3hWHrivN91S6H8zmyJAZasCZXs2y/7aCisTfMEQvG+Q2YtqYHntCZSJtqylxGMYXu2mPlh1ovWFyN/hzcJoXnpLuayi4GFSngphUvhBkYukQF68SEw==
X-YMail-OSG: fkJNkBQVM1l88LWsGms_c8LwxfW_dlrT2KOLkWK7fRq3v1qO0awvH4jtBTht2IL
 n94dwBPyBRR7cZ9BggbmCeQ1T5kvv0vnTP0uc_JsSH5dnQKO4WIf7aZqTDO37UIc6xdMEppYwRI4
 _2TI2z6UpuAmm.j_NKn70hH5cQlx7NPcSheHYflrU5tGFyFh0GTnozfLtgsbyxzHG5wQoxO_Pbhw
 1BxzyJbG6TZjKcsUNcQPfMeT4MI5sAXi3mGYLQPs67x550H1ZtmXUyU.c8fAMrHi3rIQV9LbMcPL
 0YAakXSWHQ6kCUnYLWF4r7UDgEmdAq2oFH6ZCCw3yW0I2_8kDuq1kLt6XuAQnppRV9DI_9d.wA5_
 1keuE.cWLIt2wBU4wjMFmmAKV2Q85t64eO2qOI3O_EhTB8Sv4.dOLa_QDWxBphKH.QE2DqLNKsWE
 WUqBZ3drQ37cePtAqyORy50JXMVnwpEYuMHhNegjKllWt.NNv7fBNDxumNtJWnh9g2VpX3vv5.wJ
 4urvWGcq35tkBQk5Q3jJbxILmqkn.iJv0.FRW5zNa8EO9sXwgNQKsPaB1HLPxexk9VYgVPSF_cEF
 uHLySw9LC7w1yEukAAqTmU_VfbF9sUcXgfKyu67M2gucNzgJaKAeZ7AUEygsIma0WUTRCVT_Bd95
 geN7e9WfKRoyEhvUKADhoZ4vQ2VcTCudcpQf4zqkzpSrAsuodK3gkKi0mol8m7gHhtKXrbsoFtg9
 A65NWVWZN1cpVFINWWJULf.nw2uBta0WycrOUFUkKNN5vF7BJfBEBg_erur0bapj1XDFhMGKiTFy
 LXA50TaQX66C5oZpxlnsRZlesD535AXgtN0JA4q6.w6lULv_V8nV9mVtwpPTSeel94_ad44owtug
 o0X1AbYyjtBLhjTYqnXMytAKAOPJrBzQAzVb0cZ5D1KtkGMnK4ZjQKiurHulOlGvRl8fHol7MKd5
 YC.d_Ys_mc4PoNBDpD.ub8d_Cu9gyPIB.mfO.yHsy__Tu_PviJgZKdpPTRAGQ1Lh_8mYBm1.HGtD
 F1RkgPjLMsLF8zppxjcpnQnmjoXpCV.SUAleogqNlLWZkpO3u4xqPybysu_oErxNbJ8WQR8F34xq
 CBGbOox7.E3blH6Y.FMLrLY0nGREmEPk8T3wGcuzvRTGOz3afdo91rGf4565aPcvZ_i9kgP7.Xmm
 O.9VvcnntOVap3JcGzRBbHD3gAPufkRXMVW8gozveXlMvCljFxQ__y7TmQVXh5glcMN6NrOkIyps
 EYnH2dPi3hrO7trrfRnClvxOU6zBtGn9DgNWDb2EYt5gDbmuNlv8SGmA.MZrP241Wd7b.Yss.PNF
 l85PVzvk0DJpfq_Pk_ckRmL5ymydwXERZCz0Zl3J8cGyjd9CRT8qnWxA.2WwRR0ttKaMZwBUWawN
 WdskgOmInV4KIbjNvFiTErfMI1JbgFWAOGy8AYUnuYwCIbDZpG8FoAEL0oKszBP0PpBd2HSJxMLH
 2JR86Fi1efBbTcgQOhN8bfmw6PlIYwgU3SAzPsBTFG_1LfyzylkeRpUqZ26bXiK9WPreUkzXBRYa
 85BQZDOV3nea_QpoRKGCyR7fk5C.HeZ6sfdCI6HwVi0KKyFShZG6sfGnbElDvRq4VGgnhBSPTWUK
 O.fpYmUmUNxVyCISysdqKcCqsxVlXAb8rjNmHyTOVS6hfI.1Aq1LaQrpFUPV5dX9ugYt9FK_O8U6
 H_sS1zcqisjdx.qWxt3V2JJRUuwf3_h.Gpa0LHxbOASHnYytx8nyJ13EBuRTHsw9VK9G5pKLN5ek
 0bZA0CjExpSpWTRPlwtQViiqF_4_8VjGsGw9lG_Ly2KDvvmXbZH0_xhIIplu3N64tNifA6GU_IGx
 u1PtzvrwoYW8_6D2oQHHkkzc6msMazX7vaahUZcC2sV1fidi1.0N7afbm.roggw4R.SxA5FVEEdN
 kHUQTEzedrw_KNEnlztUGJoMhVrdZ.yUi3SWkNyKD5C5RwX4UoiYDU4.U32BybqqoVwbZnuABOuh
 0zMecg1KF7xP4i5qK7U.sYsmpk0kU3xxibKYxe0guUFT08CyVdi2TB2VYrkAhZfZuRdemps1__PL
 JFem49fHDQmm56z8xtaHri4TwpXpakEi7aL_x6mn.gKbFGETZeCaNw6yiUgy0ykJJQAuFWTLi1oe
 HQqqsfhLTiVAn40QkSEwdPodHwAhCCrwhUc9Gx8Frmhu3Q78wB8wRgzZqB0.uIs4P32aulEwMYEU
 LJ8PZDNCadLJc6whleH4l5VjAYwkkE.B0hLI5wqM4enE-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Mar 2022 23:17:10 +0000
Received: by kubenode506.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 31ba72db2f688872efa408a84de88f92;
          Wed, 23 Mar 2022 23:17:04 +0000 (UTC)
Message-ID: <4080a088-8d4a-9631-3374-ded001d35c58@schaufler-ca.com>
Date:   Wed, 23 Mar 2022 16:17:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH] getvalues(2) prototype
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323225843.GI1609613@dread.disaster.area>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220323225843.GI1609613@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19987 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/23/2022 3:58 PM, Dave Chinner wrote:
> On Tue, Mar 22, 2022 at 08:27:12PM +0100, Miklos Szeredi wrote:
>> Add a new userspace API that allows getting multiple short values in a
>> single syscall.
>>
>> This would be useful for the following reasons:
>>
>> - Calling open/read/close for many small files is inefficient.  E.g. on my
>>    desktop invoking lsof(1) results in ~60k open + read + close calls under
>>    /proc and 90% of those are 128 bytes or less.
> How does doing the open/read/close in a single syscall make this any
> more efficient? All it saves is the overhead of a couple of
> syscalls, it doesn't reduce any of the setup or teardown overhead
> needed to read the data itself....
>
>> - Interfaces for getting various attributes and statistics are fragmented.
>>    For files we have basic stat, statx, extended attributes, file attributes
>>    (for which there are two overlapping ioctl interfaces).  For mounts and
>>    superblocks we have stat*fs as well as /proc/$PID/{mountinfo,mountstats}.
>>    The latter also has the problem on not allowing queries on a specific
>>    mount.
> https://xkcd.com/927/
>
>> - Some attributes are cheap to generate, some are expensive.  Allowing
>>    userspace to select which ones it needs should allow optimizing queries.
>>
>> - Adding an ascii namespace should allow easy extension and self
>>    description.
>>
>> - The values can be text or binary, whichever is fits best.
>>
>> The interface definition is:
>>
>> struct name_val {
>> 	const char *name;	/* in */
>> 	struct iovec value_in;	/* in */
>> 	struct iovec value_out;	/* out */
>> 	uint32_t error;		/* out */
>> 	uint32_t reserved;
>> };
> Ahhh, XFS_IOC_ATTRMULTI_BY_HANDLE reborn. This is how xfsdump gets
> and sets attributes efficiently when dumping and restoring files -
> it's an interface that allows batches of xattr operations to be run
> on a file in a single syscall.
>
> I've said in the past when discussing things like statx() that maybe
> everything should be addressable via the xattr namespace and
> set/queried via xattr names regardless of how the filesystem stores
> the data. The VFS/filesystem simply translates the name to the
> storage location of the information. It might be held in xattrs, but
> it could just be a flag bit in an inode field.
>
> Then we just get named xattrs in batches from an open fd.
>
>> int getvalues(int dfd, const char *path, struct name_val *vec, size_t num,
>> 	      unsigned int flags);
>>
>> @dfd and @path are used to lookup object $ORIGIN.  @vec contains @num
>> name/value descriptors.  @flags contains lookup flags for @path.
>>
>> The syscall returns the number of values filled or an error.
>>
>> A single name/value descriptor has the following fields:
>>
>> @name describes the object whose value is to be returned.  E.g.
>>
>> mnt                    - list of mount parameters
>> mnt:mountpoint         - the mountpoint of the mount of $ORIGIN
>> mntns                  - list of mount ID's reachable from the current root
>> mntns:21:parentid      - parent ID of the mount with ID of 21
>> xattr:security.selinux - the security.selinux extended attribute
>> data:foo/bar           - the data contained in file $ORIGIN/foo/bar
> How are these different from just declaring new xattr namespaces for
> these things. e.g. open any file and list the xattrs in the
> xattr:mount.mnt namespace to get the list of mount parameters for
> that mount.

There is a significant and vocal set of people who dislike xattrs
passionately. I often hear them whinging whenever someone proposes
using them. I think that your suggestion has all the advantages of
the getvalues(2) interface while also addressing its shortcomings.
If we could get it past the anti-xattr crowd we might have something.
You could even provide getvalues() on top of it.

>
> Why do we need a new "xattr in everything but name" interface when
> we could just extend the one we've already got and formalise a new,
> cleaner version of xattr batch APIs that have been around for 20-odd
> years already?
>
> Cheers,
>
> Dave.
>
