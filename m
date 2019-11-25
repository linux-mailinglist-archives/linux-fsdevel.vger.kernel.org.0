Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 337511089FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 09:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfKYIVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 03:21:36 -0500
Received: from mout.web.de ([212.227.17.12]:37341 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfKYIVg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574670000;
        bh=surQqpJyonhcHiUTKZyAw8QFhZ/+ByKRymxiX1yWm6I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IjkBA2VWvw42U3tjFpVsBZzCoGsT/BR1LpKGcW2mwZfI6EEdCKMx7te4JXLImkCaI
         rD4waylcLXG1hX3ZnFpYA8ASDbxvlSStXkcTOd0trkcdYYfIHTmMRG6/4HOcPjqoMs
         /p6gtONqgOZUsRDf33Th+DxBULnNHx6CUaWmbCME=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.130.213]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LjJH1-1hxsZr1bbD-00dVMV; Mon, 25
 Nov 2019 09:20:00 +0100
Subject: Re: [PATCH v5 00/13] add the latest exfat driver
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <CGME20191125000627epcas1p376a5a32c90e491f8cac92d053fb5e453@epcas1p3.samsung.com>
 <20191125000326.24561-1-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <95764839-45a3-651a-ae92-cdc788c5cb72@web.de>
Date:   Mon, 25 Nov 2019 09:19:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125000326.24561-1-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8nKqGtEYYDR9bB5bTnlNXJNftsHpqrC7P571PiYaB+QJQzYjP/5
 PONTv0S5DFu1hHh3/1VOhbn6uXqA+Pv7TgtiG4v9lRPVQwW4mhIf+w2kiFkRYQ31578LL0Z
 GDbIgT9bEHhPjdBxlf5McG9DCb8hNspZlwMwTqaNIY510WRlfq+6Pzlmg/L4Af2644anjBC
 xi6VO2KNUWlDKGo2Slxlw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bDuGSjBcDKE=:41mlSNHX3ddaX84epxoKnD
 mv1/QC5UmINCDAGQW9zqH+8i1wg7Yo8aJ/E9Brj/delIAX/XH4JisDYlog+w0uCnoE4C5IIeC
 JnqP/HPQdE65K1IvK2yy2nJClM6MP04F0XlE4EVy71C0ByXXyW87atE3GdsUOCX1Us+0pz0Y7
 Gdyx0kkvJudXCkHbLwOHOROJU+E7N2pAT7ITndv4qZi3vmNjVihofXxqlGnWHT0mg5UHXwld/
 N8IQfdYZfvTm7kAptwOAv3Eg2rztHFwKjg5k7uyCBO8bvtpA/Ce1uVwuOZZJnq6VnzC+bZVuE
 vaXZf1AhGmS+RrbZtf1Xp2MeLHkEPbFW5xl5Ff+zPybfuqR97hIKsn7fAWKZJGIX+EMSWMQb/
 FXwy3n8o0zreHLe4fS5bFJ+Eqi0vrwXT9RFvurKdXvZhUOvlB6gEHk1T25AlU/1rgBMJ0Wl8k
 EvwfoGGq9aI4gRTjCP54o5M0JxKBsIzivesQRk50QS4+SlwJCPU4DK9a3Yqxf7LjV3iUqc7q2
 42idR83HI2NxSbinnJ3ISsXptZeTUxZB7l7GzWt4b6r3zw0TUbo6dvC/QiWuZxO/QxWHY3pjB
 URSl5FM9TLI3HImc/+YqHRQD9h0gdPF/rXx9fDdnR9ccc6sEDgGWKr0Pif6+xW5WdSfM4e8m+
 Ox3WnfMJSOyZYgOBlv7PHVaP4ijikMA+6tOv7Eld7vu+VH7wAzaKtlRT4df1V6NSUp0SIp9cI
 0U2vx9j+T6neRGKUVa5D9OQjg4PDk/cQ5L/bA35hZtqSRiH/ea52BIi2tR08SZJGtNyxXrt50
 rxOn2wOcLOaNfK/XGBCMyRvnic0q3lbIwYs4izHMmODmhYP+1oCUaVxxL4yidnrIk8a1t79zp
 cdTjvNQO+KOq+xu9PSviEgSKyU7CH6szlUEXmIJJOF4I3M578IhC+MgOWf97yQFvTYMTIN2Pz
 YLTHGSjGgC/xYe+z8Aog44GJWBPvSFK+reNjpCRp+Chqz0hYHI45/ks5EJiNLUUuCfCj6aM2f
 98LVCNU5dPSMYN0WMlgdOOWSa1H05PWoj5uuQIm0slDt82xOIImdIaOjz4fP5gE6Btp9xs0D3
 J/DZkMorvZhEmW+cTHIBvNgxXrDdenwiB1ZgoX5JR3/6RwYmHDfw1HqyeD3FO2Ppk5WSejle6
 Qs34aXEqSRUOOs+JeFgvn5oIws4n3z/DYjuMo8ogv7Y5kq71ICOqkiccxYGoQDVo5H32XGIEJ
 BlToyZGocpaYStmLRmlN/0K/CP51dtEjsr+VyazIryBFTpvZUhA+pOKMV7wg=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> v5:
=E2=80=A6
>  - Move brelse to the end of the while loop and rename label with
>    free_table in exfat_load_upcase_table.

* Was a renaming to (instead of =E2=80=9Cwith=E2=80=9D) an other identifie=
r performed?

* Is it interesting that this function implementation could be still impro=
ved
  (besides others)?

Regards,
Markus
