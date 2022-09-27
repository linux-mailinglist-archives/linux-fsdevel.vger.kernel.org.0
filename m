Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCA85EC599
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 16:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiI0OL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiI0OL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:11:27 -0400
Received: from sonic308-14.consmr.mail.ne1.yahoo.com (sonic308-14.consmr.mail.ne1.yahoo.com [66.163.187.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FEBB1B9A
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664287883; bh=VbbF7vZK7ninv1719Isw2uAjRQZdCgxwYIQDJl7ri+c=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XP9LWajkoYh1y8U0FtfjPIqqz/UcsswOAOcq+GbnAhFAz3svv6qLtuLRVjdfX1fDVr3iWsD7K/bo3vszCjxs7bDuZz6hboDHW7/jvkJj1+R67MGUyg/a4K4x65Tslj38X6jLOgcMwoFHzCVvAJjUYV3OmrAFd1BcaElUhT7gXRmFaCJ178r0bYgse9IV7iZ4U25d5XKiL575cUfYd0vDCAeYKAf1js+NeRy52mrrmHOTQ3YdM/cKexYGK2hkXwOlWTMuFTTiYUhlxbaYvrVDYxB503mCBNd+eg5Uei+ktaDNMDuaVXh7EGJzDJxX136Cwsjgm2Jmwx0A0y41VtJZtg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664287883; bh=gQcP6WJuJItVDood1xIg8QPItxtymCASPfvXoF9A/fT=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cQ4bwcBOrLMLBv9x6xrce+/EcEGYAyZp4CKTzELim1NozExCR7eIYc+qRh5Gaar0sFU0skd24DkyOP6D1d6Bh4i8MIOpzI2950UjX5KJTridF1doPa4MDHJaGEsMoiSk5LmiV81lb/NdcdxKJvYEJ5HNkigG1wDZdH87vXaTUK6mPdqURPtBcskFkaU8VH216lIwS910T0oMUQnf45ChTkmDuhDkG5zRtwXKd/ggbpV/aXQHHUZFvAY252cnAJ4dQZWGnM5C+4fxYjQW4BGS7vgG89wL3+REEdywPA2Mg3NGajfEr5Z4eO6MpGJBglRoNGHYwmGc3C5mOa0o8ugF7A==
X-YMail-OSG: b0mai7cVM1keEOxbDY7kO4AYtPHDcMmt1OO3HgbD2YLEE9Tr8EPeNHlvo.pXD9c
 aBh0Kn0t.9uI6up1CSYEC4HMtpsX0f07rvNRN3I8BAHo5Jmoy_W7EPzw6oJh5yudl6Z_eKvhRIJt
 dzdqYltYE20SOcBvl58Amwq4gHuS_mID_yt27RIm1M2WWUtQhh0RR.rWP2Jer_9egxqpty.FSlDx
 nuQMQSW1H5R._YWLUhpdmyef2AdRdski8tecW7s_zE6JsWr09mQ3r.JtHa_IgdZElaUOdXBjh1eR
 d8_q9P9.hGHQyLKGCUD4v3sS9FxNjspI.dHSAEsdsCJdrTCCqHaUfcYM0.QjXi83fTsV6ufQJePF
 _1rUvaSikUNRZbuQeEI24bQzjsseeVkmpOB6unM2KF6XWShZvosMn488t6UHEwYj8kXUJO5UygOz
 W2djyNhSBqrb2_uYV3CztoFkEWqAoYt9pYeb7BJaVnZAYw4C0Z6LTpWr1xvoxgh.kwkEl8V0C8OJ
 ugMrNaOD3DCXKlZcfE6VKl0JBXiaZxCimbmSP0nac1e.ADGLuFUw84CBW1AmNKL1jpWRQA7fs4ft
 ZzeBw7j3CmiXQQQPlPVGiaNw02AkyTTGKQFJITYkhYh9Lx5UuBKx98cllaGyqbeNgGYTooCoCDwY
 6nd3HNfT9Pri7vI2OClGWcAppGamIW6ffcbtRoBFceMPsqrLCuZtsO7iHkbJ0KWSdc7wfpVKs3Cl
 F97bJlrS95LkYTVJiZo4iuvuO74J7B2mWBrGqfbteADwbmwEJwEadQBhxcJs8sXnAqrgHZITY.Br
 eBBLFNCoWT6zPWFKmCu0yiVK9R3b0HlnED_ohaIegP9Evu6YQY3Bfov3UXPGOcM1Rq3Qts.YQPhM
 TGEJTw0wy4VD7srs97n.mTOCA6Iwp7khP.YguSfWOhNQVVMCI5Nrp6Rx9g1IVdDGLX72idZcdGLK
 3REBBqOuQDMiMxQ63HCW667wGvOjMK5gMXEb1NGbHi26pqjSeZqEmU_gTH5TdE_3Y8qrRnjxr_vk
 aPwrYNVIuPlQFamPHBMFe0QPSoWv8xzGeweEtAhZTUas5GkZkN3Vt_u2SOzbNFgArX815jPbyVjq
 dTR43Z_oHkNf7lzFospdTk5j1w85FjJCQfwJ4W6BQfmBxPmVJm09wiHVQtZ1bec06C_IyPhrd6zn
 q9n34af.98ddo.0AbKvhBhc9TMQwKQmQjOf5vwRBXOaVQt1UGdb46VJW7GCxYb03ca9NigR2o9mx
 Rv_mj5DZiIRjUIxGdK0r5Wus.VoEWXz3aYuFjteTJL.BJH4_WUDzMB3AxXi.wpCOk4nkvYsJktM8
 jGcTBsYsVF2j80r3a_U38nfl9TwVdMR12lv1ExlkdXTguMDHHOR3S1gnwKUYA1FuIzZytYgHkOQ3
 QeRlN9LJokZKnTQdSRGz.xxieT7EK8TPp_bNEIbnO9mfc6KnCm9FUpsn_V5eSv0Afo_ess6kliES
 o718WG4zHelpSxVAjk4V3dgq5Km_XBFL4cvWvOAF3dCPa4mfeiaAIi3SHCmAv3V5Uua95HpT1DcS
 jGKUNHz7hLRcSgj8SWw041e5EqaABlgf5uJVJ._mol3SpS6cX05VJf0GrFZSAEBSxr2lqiVos1G4
 Ar9p_Uxil_AV1q7hXVm0yi2pOYMkSsKrJwwWq.fDiak17L7a1OCypzfQe9GBUJuv.x4Qjc0OxdBg
 YssAApAX12qq1uJ4LLkwZoOqoea7b1qkDkUOJDCj0bWNKFscbdvT0H5N7otCI7CP6q6CiPd74xWS
 LDnHliAONsLNdj4.23nDL_J3tPvyRljTnqRji5m9a2UPkWpA1M7FmFJUpsSwnxC6qNZ6tH0XPYMS
 qmUbiYuOEkXqTwMMYppzyMPZoLHXKkcTVGZMiM7YJ_wfLnQMzMDp2s0XlbT_AfvmtHmF4bn3Tw.8
 w4Y6Vre5.yc5ShF_xiWxcR1gJGakh6J_nRV1OUIv4tkN8K6GHpXK8IdHPFLKJ8max76JzbXs.hUs
 RdH_AZYQzpYs2wUg2L7uSU_kBNMZgcWzjSeyRZl2W0EXjLDrP24VV4oQzgJuGkqxzB5uAgsEa4kY
 dlbwzA65Rxta5NW4xPxi5ikW5rFdCuD39t8KnCHT0f0evm6MK.PvrpFwAgQPWUOuZloGs5UEjSyc
 D1MBQ0tCtoYjxJ9RI_zNpLMJ37qG0QZNJr1MveXpKVvWxNy4qYyBCsdgEtiwtfnM5GhypRivykpx
 eECj7kSr1meznWtbMkgNtdTa7pwb_rZ.86RoIH8hBfHXgPua3oW3yPaaRSMK9Gv90bPnon1qtuqv
 NtJNUoh5WwEdisXrpZV2btBm.RqXUPy8R
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 14:11:23 +0000
Received: by hermes--production-bf1-759bcdd488-njfbl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7ae96f197d73b97f0f772f8199eec96a;
          Tue, 27 Sep 2022 14:11:20 +0000 (UTC)
Message-ID: <a0cf3efb-dea1-9cb0-2365-2bcc2ca1fdba@schaufler-ca.com>
Date:   Tue, 27 Sep 2022 07:11:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 00/30] acl: add vfs posix acl api
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, casey@schaufler-ca.com
References: <20220926140827.142806-1-brauner@kernel.org>
 <99173046-ab2e-14de-7252-50cac1f05d27@schaufler-ca.com>
 <20220927074101.GA17464@lst.de>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220927074101.GA17464@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20702 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/2022 12:41 AM, Christoph Hellwig wrote:
> On Mon, Sep 26, 2022 at 05:22:45PM -0700, Casey Schaufler wrote:
>> I suggest that you might focus on the acl/evm interface rather than the entire
>> LSM interface. Unless there's a serious plan to make ima/evm into a proper LSM
>> I don't see how the breadth of this patch set is appropriate.
> Umm. The problem is the historically the Linux xattr interface was
> intended for unstructured data, while some of it is very much structured
> and requires interpretation by the VFS and associated entities.  So
> splitting these out and add proper interface is absolutely the right
> thing to do and long overdue (also for other thing like capabilities).
> It might make things a little more verbose for LSM, but it fixes a very
> real problem.

Here's the problem I see. All of the LSMs see xattrs, except for their own,
as opaque objects. Introducing LSM hooks to address the data interpretation
issues between VFS and EVM, which is not an LSM, adds to an already overlarge
and interface. And the "real" users of the interface don't need the new hook.
I'm not saying that the ACL doesn't have problems. I'm not saying that the
solution you've proposed isn't better than what's there now. I am saying that
using LSM as a conduit between VFS and EVM at the expense of the rest of the
modules is dubious. A lot of change to LSM for no value to LSM.

I am not adamant about this. A whole lot worse has been done for worse reasons.
But as Paul says, we're overdue to make an effort to keep the LSM interface sane.

