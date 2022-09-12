Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274965B52FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 06:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiILEEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 00:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiILEED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 00:04:03 -0400
Received: from sonic302-26.consmr.mail.ne1.yahoo.com (sonic302-26.consmr.mail.ne1.yahoo.com [66.163.186.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020F0140D1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Sep 2022 21:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662955440; bh=7C4O2HzfkDB2JUgsGoWLBIX3FcwiIG0KjKxfRDa2Qkc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=OJwFaxQJ41wiB3fy08VBxthvfrHCQaK2NqbUXxE0Hl8/qb+JANrssdhQ1HJ1Ki8Rw/BCmoQI9vINaaasyeA4WVjxYBz33+a+N4mCvDWtaYCSYXVkQsplaPTCy0NKAr5lIymodELzOO0Pl40qja3eo+mIBzMwHs6G0Axm2EOoaSdwq5FvRqKNFt/zj3OlvINxHKDw1CP/Swi79CPv3hP3fpjxrw6PX8+VyPl3muyAy+DqkIOBhnA1Wa6klZZ4FEAQplx6xSRJONZ/UQduIDF7yRaC4ftLUp0qnUEWY3Q+b6xXCTF1N7w3iOCoRUWB7cPHJpsIFbZOolIt31Ex3o8iKA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662955440; bh=zGQfMEG3duSTfJBtd4VxyPXJrOReAFdvwjz/TsTMZbt=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pvbI+DQmMpLP9XUzt0dYhs8WPUR58AMOb+j4PDL88vGzebnvc2B0WiXzd0Q9CDedn/r856sm7h3MIDB9xSDF0+x0H/SEH3o03o6QX75pdyzXaAVEyAQQ0PPrhXBxRzl7K63doPCx3IhPXGcKybUdmsGXRsKre+C9qZ0rxFH1G0OJKuHb3cOATqu5KjuaZkfQVVHPO0+bz7/mgtzlDH2d+pIU5QH+1M4f/kiUZV6z7/UMfBMdgPG7jERz+r728FkxOZVtvJZ04h9r9p8oNiMsmJvugZgi5a2DlvL6JxUITssXPhHoPtZXEPvqfY2WnxrW3PtqD+yIzaFMAw+s6fyQzw==
X-YMail-OSG: bus_QZcVM1liI_8YVBC5MhHJBMUHxz1jaASZl7OeQyprPSohs1T2804NoOTfIIU
 FAnGGcfdF3IdGpxhdMSeLMMPXDZIzU.BWG0HBRwrk9VETnXk36rB0nXgSdsSAKF0USDkVOGJeP2.
 ibVgQVapAPsnB0jaua.jFY._KsEriEvxFyFcJ80XmUvJPyZg_JuOy3urNvxQ6EtFh2hHsnKArehB
 .F8CvdvtQuMSPQfHC_EtOWJiULHZKTF8.QUI9vnQsWmpZQaGht6Fpzb6Ns0O52uTZ9m6c4SdT_0y
 IehIfYfV1O2JDb6rdkt3T8hjcuCEqTxm_Etb4wS6gcIbnUf0N_HMTPNWnlSTVtFPg1jeirOVCTC9
 4shk06YyZINv7dMXMLrrdQWCaLWXryuqTopEw9QtB2dDpQZFKXobuPbZm8rfX_8D3fbPMU6_jnHg
 yMStNPr1QiOO8a3OzU3iy3tnbYPkxnwIY8InIv4nYiUzDEdmYxj1CgR2CKJUp5Ob64G51lAlwC.N
 6Eref.LCKZHk_pQif70ZP61n5Zy6JA2P0wxhWZ5A7quIdJ5haf4B9zQ6EhNYXa7fWijj1Av9_pCo
 ZOVZU1DOhg7yjJng3PgI6MZoivzL3gSLvBYB.2MhXKbWlnap5wcYVEWpHKF50vYts.N1swKb.K7F
 065Rf4wF8B.ukXN.2K7wUnwZRoAW8hvjchRgpHwArJw73XJvKj0aCNccPahn9H8I5C.tTZfWNRnn
 swNO5hJBNyqDwsVlOw2a0uuSadey4DTRfN_TjJDZZulRB9_xFgJUwiRU8qYFrIsjSpxZ.1RX6c.5
 ACKny9N7cnrIyZ9KgjWPgUMT96d4EXbL9ehYgNpYieNZRgFqVpNd.LUxRZHHYolPBFHe.hasy8.Z
 A9xnm0FWbqV5xkav1wxeMn9YXVwZkdN6Yy4SzGHw50OVOE8YZqDkqVgUtP57JK5ZnF1gvnjncj8e
 zA9W8bDIqE3yPr9qbOJjAhPh3vDM4y2xPrW_R.Iu30fqyQgPm4fR2xlrsMy9WyvZVhyTqoB5APJ2
 Cz.SzW8ihbW1PLtX8EvBjVK_FmsvRDSsYPUrzhasnfDoJ3l0ZpmSFq5Qah1VxVEguIFVXQUqeFf3
 lLy5kAxOrYru6Jrl.gt4r6a8XQEMr.FJLkat3OJuTUIOesRx9QoXKHg3IlEQsYgrmi3uRUnwR0iL
 GORByYtCbwGIToPv13bDBjXQLWC6ZQd7DjoxVCW2Nu3A75EzJQCl38Jfejgs7J9.wEJSUhwyAsw9
 OXlYcdQZnR4U7k_fSaEe1wArfJ7tnCuYCwxnSxPQyt7mEkA8KkIMkiT3pkCgPyIQq4Xs55jDdz6P
 Irv40M_Vs6J6EiNHiCpFC2KnG4vvbwxSqqyVSJbd0u7N8DbEfns0m_uSNKZdbTleac6cU_SSS9TI
 VN02UPLhFL3f3bKJiiWefYWK1jt8aizmyMleXFz4xWD1T9DhG._62NYozQH7IFok.WZ3mtmoakQf
 2mM37xhXgIC_Jw1S7SD2ck9T3SZ1UPoaNjPhjH8BNrjS5_1L9dYcksOWtltKQduVsMmeHLJwV7f6
 h3oTOkQeUoz625AtJuj58SntbUnL83nLEkMzQusKiPWFdUb7NyLFEVaC2iZdPylXqodwMV67Mgux
 FJzralF4s1qidRoQXBJJ24pJXybe3EsOWRbKQqWvbMOfF6RiSTgWSJ_LwQ_NPS_pD8UeZ.ZEcerb
 6X7U2.nSsr.D.xy3F2cO4u_hf4eTNfRs4nrA7SScZTySx_7wTFg8NyCvc7eY6TdgBNgfJ44sOmrD
 pEHCEd4Xh7nLrjefBEFtDngxgwq3ZYLJysJ9eSO82Fwqbc7RzMJua4rB6Mln9boZHug5OTRX09DL
 zTb0kKKP6zRyt6en9mNRuzptWFzgEhzH42yt84JFFhjyI_puT3noEeLNFT9KnqbLp13ZuHh7jwh2
 83lujWcN2BFZcG4HJ8zapFtwHzGZs2c41lvmPS3suu7.yBKaiXu3HEu3Yn4.YeaV.jYSplxa5_KD
 Hi7Boh9ev2qjgAw4foiZkv1LaOjpKJkgj3.njqcUNSLxaH_IbRwr2xOfPe9OdG5vkVek2DM8R.fo
 JDttijWnnEXUYXnnWuLEvkeAqPsmtd2pWUhNwXZZmS6Az7zSa.QSsDUuUbmGQ_xgWyCN_2pksBy_
 zUqpBt9ZvNhMNw5B5tshOqg3CPBKnPjfgr9Fyg0jZZK3UciDz.iX3a_JqLNosD1pmkaBdrymbXt3
 5jHut7fOBxW9uXE472IUaW3VneoYZ0OPrcubnT7MSBawZrvMqx50XjjyCz5JoRClNBevhOKSU7he
 .tQxsBuUVQgU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Sep 2022 04:04:00 +0000
Received: by hermes--production-gq1-5499fdd576-dl2rj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5bc4dae1e3808d755ab5454ef596dc5a;
          Mon, 12 Sep 2022 04:03:55 +0000 (UTC)
Message-ID: <ee70a6bf-898c-63aa-c513-6c2f0f307f2b@schaufler-ca.com>
Date:   Sun, 11 Sep 2022 21:03:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Does NFS support Linux Capabilities
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        battery dude <jyf007@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        casey@schaufler-ca.com
References: <CAMBbDaF2Ni0gMRKNeFTQwgAOPPYy7RLXYwDJyZ1edq=tfATFzw@mail.gmail.com>
 <1D8F1768-D42A-4775-9B0E-B507D5F9E51E@oracle.com> <YxsGIoFlKkpQdSDY@mit.edu>
 <8865e109-3ec6-f848-8014-9fe58e3876f4@schaufler-ca.com>
 <Yx2xyW5n0ECZX9bJ@mit.edu>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <Yx2xyW5n0ECZX9bJ@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,LOTS_OF_MONEY,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/11/2022 3:00 AM, Theodore Ts'o wrote:
> On Fri, Sep 09, 2022 at 08:59:41AM -0700, Casey Schaufler wrote:
>> Data General's UNIX system supported in excess of 330 capabilities.
>> Linux is currently using 40. Linux has deviated substantially from
>> the Withdrawn Draft, especially in the handling of effective capabilities.
>> I believe that you could support POSIX capabilities or Linux capabilities,
>> but an attempt to support both is impractical.
> Yeah, good point, I had forgotten about how we (Linux) ended up
> diverging from POSIX 1.e when we changed how effective capabilities
> were calculated.
>
>> Supporting any given UNIX implementation is possible, but once you
>> get past the POSIX defined capabilities into the vendor specific
>> ones interoperability ain't gonna happen.
> And from an NFS perspective, if we had (for example) a Trusted Solaris
> trying to emulate Linux binaries over NFS with capabilities masks, I
> suspect trying to map Linux's Capabilities onto Trusted Solaris's
> implementation of POSIX 1.e would be the least of Oracle's technical
> challenges.  :-)
>
>>> .. and this is why the C2 by '92 initiative was doomed to failure,
>>> and why Posix.1e never completed the standardization process.  :-)
>> The POSIX.1e effort wasn't completed because vendors lost interest
>> in the standards process and because they lost interest in the
>> evaluated security process.
> It was my sense was that the reason why they lost interested in the
> evaluated security process was simply that the business case didn't
> make any sense.  That is, the $$$ they might get from US Government
> sales was probability not worth the opportunity cost of the engineers
> tasked to work on Trusted {AIX,DG,HPUX,Solaris}.  Heck, I'm not sure
> the revenue would balance out the _costs_, let alone the opportunity
> costs...

A B1 evaluation cost the vendor $1M/year for 3 years. At the time we were
selling large systems for $10M-20M, so you didn't have to sell very many
to justify the expense. Alas, salesmanship beats technological leadership
more often than you'd hope.

>> Granularity was always a bone of contention in the working group.
>> What's sad is that granularity wasn't the driving force behind capabilities.
>> The important point was to separate privilege from UID 0. In the end
>> I think we'd have been better off with one capability, CAP_PRIVILEGED,
>> defined in the specification and a note saying that beyond that you were
>> on your own.
> Well, hey, we almost have that already, sort of --- CAP_SYS_ADMIN ==
> "root", for almost all intents and purposes.  :-)

My, but did we have trouble teaching evaluators about CAP_SYS_ADMIN.
They had a very hard time understanding why we had to have a capability
for things that had nothing to do with the system security policy.
The problem is that including what CAP_SYS_ADMIN does in a "real"
security policy introduces an level of complexity that makes any kind
of analysis impractical. How does the ioctl() that reverses the spin
on a disk drive relate to DAC or MAC? What are the objects involved?

The big issue is that so few Linux kernel developers understand what
the Linux security policy is. So much emphasis has gone into "least
privilege" and "fine granularity" that it is rare to find someone who
is willing to think about the big picture.

> 						- Ted
