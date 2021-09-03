Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674C44002CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 18:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349849AbhICQCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 12:02:33 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:34833
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349846AbhICQCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630684892; bh=lz1PwBXHGViBIV61NAkWI89twfzj/A5LlwKuVkadHXo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=dCnWZn3DXEbyNrX74tvC249Kyxs1SOZjEgRgfyQUE8g1ySGAMDOXo6mtEHj6BWGgpnRHRh5DE9mTYnRXPSFwgTTSRsIRcbsy3YBcJnNlmnyqIBEywDKGzw2MY7kd+81GgWiorSuskUcz0bT6DQof68pI81lbG/9FyYxCPNQMbhFNMcpkV59O4FjqXerWiO3MUWB08XJuBhJiHJITVnXC72dBl4VLjxNZ0PZdHDat/lhOlTIsY63vseEvb1lM+lKCmK2y1cO5mx3cB8rtpUbW2nXd2/ZIEBneGmuFynMnf6lcqP+YmA3u2NY1hxUBLoPCaDANxBRQdG8/F2l1hkWZrA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630684892; bh=sl5FW2A+1Htrq7v6q/E6qT6dQskOP4BPwU/5z1UMa8k=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=mVREUUjFjj47v3nR5GA91aO5dl6aTWmKbd+yMcLxGw+z7GCo0vdnkODTMEvb2za5UsGdG74Rj6fmrtf+CyH8q/9uoruLVuQ6g3RoEAYtqsvL0mAwPgnQ/HjxGSS2nox2pbslGPrfDAYixzbJfMIUolRYSf4TV3zShkjw5k5e7MhDKiQsSDMcDZDW5NvkvKxnQ7Mk3xcrPFkarDjqkEuRSyf2lRVDmpRYy0pCSvbpmPkpwTuAXEmzsQ6XJKTmbN7Zf5k3dRO9Jfruj0OOr8cWjbj2a4ocYRnGsTViyOWL3kIsUCDIE+9z+x1hKo28Y6S0i20NYBNH70BzO+PSIEe+Vg==
X-YMail-OSG: sYrEGy0VM1kkU74hwM05q4E.41JCrWunGeqCD_s3uhCjK2kGp9iQxEgCpJfzSen
 b4.ntUCUWCToW3kmHTUD8fTKh93JNnqhwukRUNs7DC3RtfOeZE1GQPf5XxRxTaQ.bHkHO3mb2OXC
 _Rh347mCVZS8Olp7HjGOOOqatC4YgnZX7QGtwe9rO8UXNduREoFhbNNHyEqZ_34tSBVG3y7N55rr
 wlB.ULr5b66iPsoEWS72n.fd4kREKYW61YUtmaJgUr3E0yI2A0CRLqLk19KmGmus1mclq4.lvCyf
 33bWww29dRJXt5Uef3oqpOaQlirPi1Ot1Sz2pWtYjCvBBwRNwebfDhJERklMUoOxNtFFR6QMV1Uv
 ad.XLrgd9OQCuSIU7cWJ4yagaCYtzd18n52gUNP36gpt8Bc.l7cV2JM2l8yG4cEp_QW.I7iKU1eD
 4bLb_9Aguy7PFoVnpg2S0ZSQbwdt.TMW56TlN7c1OEkkGWjffz3ka8b67a9E_D2eRdJ549RAJEX4
 4We4i63810wcQ3eYJYaCg9j0KdwOVO6AKYYXoycl6v6if1UnxyTVqDeCkDH0lNOfVXxbyEsolE41
 xUJ1ssQMfuAZqXfbEyJCJEKfx2GUnu8w5fcrpMlzuRn_6M9UnOKcpQSFysddrFUG7oy1PAOsJ0rv
 CB1BCixYCZLG6jOKjUVcVycDIkJNyO0djLYL4YcEAvJgzGtvh7hwFVBvMx55vXht9fJ29VAoWxKG
 mDcCkSQauVtbLRQo9RgNUX24N87AKoOxYNUUj8AEGlL5BVq2l9DBb3snICy.BxefOr5GcUCZ0XdM
 ETmJodxc7XZF2qvXPxLizyIoJB.UIG1JId24KtrsXUlMrwpHQK7H5doAuWVw9WII0u69yy6Ajcq.
 t091HTmrV0kYagPLqHz.bALlqjn6FSEP7JJYOQrF7qwZDrLL77sPOOXagT0yQOtPmXJZ6moeRFAM
 k0p0JI3zuhTe0nKi.gtkgXELR1NN0bBZxDinuwnyPqes5oqcBhjzm6j5Yuv_Gr6PWN1A61Y6NlAz
 5PHxZe8yXh4.wquEvDCdk1jGv4ZNE6dKrqU0JSY3odDQ.zTFypr.0pTXcksQhyGjLDzya4FDINMZ
 up.G70bYj_imsiH81gNisckXmg.9uTMZSXQFghyC3ay9DfGotW.tb7JI2pgHWlUxbhVE5HBF0KMb
 305bw8itKuqUA2ZRYKsP7DqDMfeWUGL9HvFiFV7nV5V59bEL3OkY2BwhiWRqnNj6FO6.2EIDnzNj
 q8D2LsB7O1uPhR.1u2Ni05SbzGTwdZPeJqfucgN7yyiqo_zXtPqVn0ZyUYMuKRKEsvYQKiT9Ti9A
 JcGyokknTfP55q4AT4AlWfWy0noAgfsgbuduJXdiBn4NgdFo9uyNObKk.s3Thrct6oSEmsN2H7PZ
 lho.S2DQmJoXrPN2TNwPNelYhR4Zb_YcKA7dXAQSMZEUFHAkqM1r4Bp2uzrmzesTSqdjGMBZKIsI
 xZZTgpq4dD.6pUQgMMRC8NJmpvze9tiVANEbhXeAoxfzW7E2bRRsg0CkXlpftS.6hh9EN4Nvbij8
 1LdaOxF8XgD7roLp_JFNfmUffHknCk1ZO1cvMImEV3J.QTawZ3kuJCeHDPHTV5azSbVjlTgESVVP
 KywSFSmJKhkjOVSm5ELnpY33MExQogdLmHBKYtsPEdYDqPFPCuLB3mD7BcRMRgfNbxtefiF6EsFx
 0qI9v3V7491UjU0dctXcg1efXQXOuR7QTRO7NPkxYa1Pa4xX2sYZehxpqLHmrcG5qsx7M6Rf.H_H
 bxMc6aPqfrX9VyRfympHBOMVlSchESWD.tI9LgzcK4sWhkWbj.RZCBfmuP1.hVMtz.gT04Uhwp9W
 PzT_bznfYcN6x8obBn1QKulsC99D.nGZ1JfibooKy_f6HYBCgx4rvEDrKn72ykaxK_wzQDRJCkMA
 lWKZHSqlBNgnsiQ9m9AtUPuC.xWmQVZndGseVelV67dgOCglZzMRLSPa6k.7RBMRTsq0_V3RwMHe
 vLF3i.rT68EtWTDFPPIVF7L7k_WDA9mAOp6RJzhKPnvQ4Rhbrduci8s7f7zJLfmE24zYNwfZDR9F
 b0L3wLN6P6TD3iGVVy3ZnTWkn.mI6Ew0u5LsAqxQEMWT6yY2zLZE1rfyO6ZqXtRJSPmGdpLQ2oQC
 41Rqag1b6RoVHFRewyiYxeuhmPP_yhaFC1DMYlNYbVdzji3s_p2yMIie16Ecwnuh3j340ctc6NAy
 FfIYUbgvI6n7dmz6zFm7c1fuHbAQkoN58BG_S718pu7ML8QYP4TBu5v.tzB7ohNhxfRqZmPnBOF4
 s0jB.3rw40P0p1zS4Pn4Jr3OJPC3jhK.uVtYSASUa81WtH6KYZsw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 Sep 2021 16:01:32 +0000
Received: by kubenode558.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6b638d9a3a8c7eec015acfa6ed23ffcb;
          Fri, 03 Sep 2021 16:01:31 +0000 (UTC)
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
To:     Bruce Fields <bfields@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        David Gilbert <dgilbert@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <YTDyE9wVQQBxS77r@redhat.com>
 <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
 <CAHc6FU5quZWQtZ3fRfM_ZseUsweEbJA0aAkZvQEF5u9MJhrqdQ@mail.gmail.com>
 <CAPL3RVH9MDoDAdiZ-nm3a4BgmRyZJUc_PV_MpsEWiuh6QPi+pA@mail.gmail.com>
 <YTJCjGH0V5yzMnQB@redhat.com>
 <CAPL3RVFB67-AqZrjjfxueQF1Jw=LmKWzCk3Ur94EjUotYMw0AA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <95fd9166-c809-5a2e-fb40-aba253c9faa6@schaufler-ca.com>
Date:   Fri, 3 Sep 2021 09:01:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPL3RVFB67-AqZrjjfxueQF1Jw=LmKWzCk3Ur94EjUotYMw0AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18924 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/3/2021 8:50 AM, Bruce Fields wrote:
> On Fri, Sep 3, 2021 at 11:43 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>> On Fri, Sep 03, 2021 at 10:42:34AM -0400, Bruce Fields wrote:
>>> Well, we could also look at supporting trusted.* xattrs over NFS.  I
>>> don't know much about them, but it looks like it wouldn't be a lot of
>>> work to specify, especially now that we've already got user xattrs?
>>> We'd just write a new internet draft that refers to the existing
>>> user.* xattr draft for most of the details.
>> Will be nice if we can support trusted.* xattrs on NFS.
> Maybe I should start a separate thread for that.  Who would need to be
> on it to be sure we get this right?

I would like to be included. It would probably be a good idea to
include the LSM list, linux-security-module@vger.kernel.org. I'll leave
the networking and filesystem folks to speak for themselves.

>
> --b.
>
