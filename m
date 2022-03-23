Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271F54E5397
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 14:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243513AbiCWNxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 09:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiCWNxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:53:14 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1B97DE27
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648043503; bh=nGrBDIOfk09I8FWc6QOIz7JQf3bHy8tyuHNVM0EP6sk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XH/bdGA55CR2QnzRtm1mRaxx2JaRO91BcAs5Av2UMiwu4WLu07z+iXTxs06NWj7lVKFCQL8yrF2ubXEKuyijcFnWuuF91/G+16JtCIevCWFuzig3aBgV9DZN+lkOMRwHkyGbAOhpmLkWPfnGdjFZRxo6Olb9P6KQmIv/UA92mlE1Abg2yMi5iwiHnK42W53EFBa3Ss7rHosmRAwblE+QaObQ9UyprpUQPmS0iOSxnL/Tuxcqb1ZQ3tVOsy5Gy5GduS+KY7KH4tYtIDljXGTuAJqRLqawoF14i+3vVJUdXaG/l7Hn+lAQepweF+xK8wdaKqEAVlFwvhYO4NV/gdS1zA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1648043503; bh=jxqTA43iFlFSWocJpudyyVWVGBeLiHSpYPxyBnWqoGn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GAHm4KTahupGqWTIl1kgIYqDhkTCXvnhCKbXHSDBI/yAqLXur3nCSCmXn8Hh8CIOukAP4tigN7bYDW+18wp9SHr6ZSpH489/Fef93tlTkUfciDzdTOHJ8PlUU7olgXRE5KVnhr2ZRerEdKlO9Pftx10iDSvwefT3mqB51l/NDTf6tUK4xNjY8STePoxmjKBXrEuVmVVrng5g6u3Wmo4jIKGyKqrd0C+GXj4vxcSeaE6EeSyqTLKvuLZYm4kqUZl7fvxvZ1S8lQXPuakaEGRDS9v85rSNh/pHC8gp5qlBtmZojQoV83Cc9p46W9vrkOh+PEfSVbEWQbHgyL6Urs1c5g==
X-YMail-OSG: arvGonAVM1klZhaOCKStvzpriEHCTWAoxpRlp0X_xhZZtLdflYMA2LLpcLa5iSA
 xk0NeP2DUUhwDP0zqv_auzFizXfSHSFoJfQE9L3BEdYhPiSzVA.2TNn1sUBfCdtAirfG_d0vtzAP
 2U4CGqeW_WcgNVDkfw.w0OO2N_BQ2XomHuBiFF3eVeFFy1VuYsXuAB7inoD3VWF_Mkibuvkc8azs
 3XbxIw7LmjTq06XlxubLXSw4iv4OpZj9rH3A2zJFBTtS9rZt3YXvi9hC5vZFr86ROKBEKSwytdAN
 EPSXU_DW8OAcFma5GQYVZxUCbkChCcQfB44xyChdcc0pPVyFgmT6i_VMW7IF06O14L38lnJ8xyfN
 j0z8N8bME1oZEa.wOt9iLj1FTYYyxNbhSCuotmrB0SoZhxzNLfQ5LTNwmT1GJdm5mrhJEjjsm68x
 46vW0j9q0wvQW2qU91psxuyaDQMrUmTiU2gKn1F7XqUe2LpWpryyu3cPH8v0wJ_fF1f1D9QV2QMX
 EQtvv9eSXGZTDB.DQOzGPXAluKicrlUslUHINzsITFLZh02loHo3lzDRWaYQvigbDYZtomcXmIBU
 3M0q9DGw2W1eZP_u0t2KV5VTsv1W772DG3qcY_7FHKGVfP2RjvdY_PJf5Dtskm_92lwUsYiUCwr0
 7C3nMqH5oIfjmH4DHz2upjZPriCm0330I8PBPNuq29Og1kcWzSFHwU7GTP_I3NIUA2olb6sYsUK1
 zKe7mOIQUlnSCJP8vc23_hGtVQz0quB_vS8j.zFdWc0e3zMMUSz.793OcmYfZDC3rJO0Jd7uWrcV
 _.tS0oZvZXmwFFi1PpQOThDKuuwLsKgqkz_CFTA39Olb6auriVfeg8DbEGY7LTrQJyQ0u1pFcAb7
 m8tLIJ6ZyuEBSl3q6wvluBQPs90ZgyPb5fWMZsW0SWxdQEKPCof87d.KpXL7PYXxKDzYKtSXp0nd
 NJ5jN8cLpY1uq4GdXeLlnIGHQA9IrgmUn1aRZ2_IfTdnxrGyAOoobkdzTtEU5.d91hsbxcCr0uzR
 vzDGM0.FS.ohEbQG91o1okWsNjMVeayOQmSARwMHEzBbePVp22ddXHvDDRXVFEFIpvqNpZ0dCcCc
 O8PXX6mcJGxj0Pf7RFiHF.nsG.OyQr_C2QgR7zJmBDF22I4IEQPEqu0mX0sUPQyl4hCquzs4u6hB
 yH7EH1wUfvFxPXgJaXsBul5efCc7Rx3KkYW_aHJfXcyPBdmN9HDt.J5muNF8WFhF50sNikOgty5V
 k6EJXJ3aOSHN4e1dl6NpDkhORJbvl5BqzELOdym2Mgsg_jNhnsLsV78mjVkVS3v0CDVECEeT6ewO
 rt1K0ycNIQ6RPslKhTiI1a8qFtkhYonavcrloLAGBqzlzoSxp0yhTIHhN28oPhjB.2rHBHoalPS1
 7RyLo65uHUWHaEsOKycDQyikhOy2GGJ7qbfEPVsNZBb0tegXHGiPUy7BlqORn63usfChD.z4NBPT
 TyCCYM29rXB..3ZMKaPbAQfpWomXW._GP1H1Qi5T8VPkMkuGbWfDQ3wunO0g4TnzBZHIAHhRRL0E
 CXSO8RwrR.RhKbE5wn1ycamXYc398SmL41jT7dSGr2ImUlUNNaA8dHtGi0ACLcj3_o2V0phgaeJS
 BZ_VGfnZkmovZdL6tQ2WQCqmOLqJcbHiYX2IaMz5A4TJtKtBz6PfiUjnDdKoq6E_.aen_Z0xIQ7p
 9ZYmZ9gkT1LSbELxrjk7VBSwVIcocmNI.XqvxgZBiWdwhv1wLdm0g2uJK8pg3sJ7uFL3DV2x2VRk
 t4FEOCc0.emlTLUFCx9eazA9B6jakct.OojXQGg6jmiAFd4x6j0HADhpE36NgMvj5rcpyMYxJ7Yy
 DqEC1iiLlAwpdVrE2wGRShH6A94vsFsjy1TeQNJTzNNx23YTvDhYack8HeIKlBk96SLPMdGSzq4w
 5OHhQe6thUvIO3WOUALlVFjnE_QL3o6hKVRzyQDtgGLKcgmrNpcQChrL2I8IEZ.3N5RF6sxUeQDk
 sonEoVlpm_7yJzCVxg_x4SxNWJZF0AEBASmx4mv08KzkkiQQQGDElY7cmbQ4FuefJUNrOaiEzbKb
 KLavixiXXAndOC5ifi18xstRJSwszXFJs0BdsHByFC0dTrae4UGZ2lkRP7h6OyJHL5lykXHG0bPC
 3YmX2VBNJd7LlS1LsLcXbRygdcImu6wZ2HVIwFow1fFkGixUsddR6o94zNM0K5yGO4RO._6NKDm0
 fdJx8gbJQPxwQoB01KFOzhQ3YsybaL0TU3Y3_ydduHouaZQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Mar 2022 13:51:43 +0000
Received: by hermes--canary-production-bf1-665cdb9985-6hz22 (VZM Hermes SMTP Server) with ESMTPA ID 1e898808bfb982390c464824ceac17fc;
          Wed, 23 Mar 2022 13:51:39 +0000 (UTC)
Message-ID: <d3333dbe-b4b7-8eb9-4a50-8526d95b5394@schaufler-ca.com>
Date:   Wed, 23 Mar 2022 06:51:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH] getvalues(2) prototype
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19894 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/23/2022 6:24 AM, Miklos Szeredi wrote:
> On Wed, 23 Mar 2022 at 12:43, Christian Brauner <brauner@kernel.org> wrote:
>
>> Yes, we really need a way to query for various fs information. I'm a bit
>> torn about the details of this interface though. I would really like if
>> we had interfaces that are really easy to use from userspace comparable
>> to statx for example.
> The reason I stated thinking about this is that Amir wanted a per-sb
> iostat interface and dumped it into /proc/PID/mountstats.  And that is
> definitely not the right way to go about this.
>
> So we could add a statfsx() and start filling in new stuff, and that's
> what Linus suggested.  But then we might need to add stuff that is not
> representable in a flat structure (like for example the stuff that
> nfs_show_stats does) and that again needs new infrastructure.
>
> Another example is task info in /proc.  Utilities are doing a crazy
> number of syscalls to get trivial information.  Why don't we have a
> procx(2) syscall?  I guess because lots of that is difficult to
> represent in a flat structure.  Just take the lsof example: tt's doing
> hundreds of thousands of syscalls on a desktop computer with just a
> few hundred processes.
>
> So I'm trying to look beyond fsinfo and about how we could better
> retrieve attributes, statistics, small bits and pieces within a
> unified framework.
>
> The ease of use argument does not really come into the picture here,
> because (unlike stat and friends) most of this info is specialized and
> will be either consumed by libraries, specialized utilities
> (util-linux, procos) or with a generic utility application that can
> query any information about anything that is exported through such an
> interface.    That applies to plain stat(2) as well: most users will
> not switch to statx() simply because that's too generic.  And that's
> fine, for info as common as struct stat a syscall is warranted.  If
> the info is more specialized, then I think a truly generic interface
> is a much better choice.
>
>>   I know having this generic as possible was the
>> goal but I'm just a bit uneasy with such interfaces. They become
>> cumbersome to use in userspace. I'm not sure if the data: part for
>> example should be in this at all. That seems a bit out of place to me.
> Good point, reduction of scope may help.
>
>> Would it be really that bad if we added multiple syscalls for different
>> types of info? For example, querying mount information could reasonably
>> be a more focussed separate system call allowing to retrieve detailed
>> mount propagation info, flags, idmappings and so on. Prior approaches to
>> solve this in a completely generic way have gotten us not very far too
>> so I'm a bit worried about this aspect too.
> And I fear that this will just result in more and more ad-hoc
> interfaces being added, because a new feature didn't quite fit the old
> API.  You can see the history of this happening all over the place
> with multiple new syscall versions being added as the old one turns
> out to be not generic enough.
>
> I think a new interface needs to
>
>    - be uniform (a single utility can be used to retrieve various
> attributes and statistics, contrast this with e.g. stat(1),
> getfattr(1), lsattr(1) not to mention various fs specific tools).
>
>   - have a hierarchical namespace (the unix path lookup is an example
> of this that stood the test of time)
>
>   - allow retrieving arbitrary text or binary data

You also need a way to get a list off what attributes are available
and/or a way to get all available attributes. Applications and especially
libraries shouldn't have to guess what information is relevant. If the
attributes change depending on the filesystem and/or LSM involved, and
they do, how can a general purpose library function know what data to
ask for?

>
> And whatever form it takes, I'm sure it will be easier to use than the
> mess we currently have in various interfaces like the mount or process
> stats.
>
> Thanks,
> Miklos
